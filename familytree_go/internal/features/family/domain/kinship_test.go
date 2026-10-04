package domain

import (
	"errors"
	"testing"

	"github.com/stretchr/testify/require"
)

func TestKinshipCalculator_DirectAndGrandparentRelationships(t *testing.T) {
	members := []*Member{
		{ID: "actor", ParentID: "father", Gender: "male", BirthDate: "2000-01-01"},
		{ID: "father", ParentID: "grandfather", Gender: "male", BirthDate: "1970-01-01"},
		{ID: "grandfather", Gender: "male", BirthDate: "1940-01-01"},
		{ID: "child", ParentID: "actor", Gender: "female", BirthDate: "2025-01-01"},
	}
	calculator, err := NewKinshipCalculator(members)
	require.NoError(t, err)

	tests := []struct {
		name       string
		targetID   string
		title      string
		kind       KinshipKind
		generation int
		side       KinshipSide
	}{
		{name: "father", targetID: "father", title: "Bố", kind: KinshipParent, generation: -1, side: KinshipSidePaternal},
		{name: "paternal grandfather", targetID: "grandfather", title: "Ông nội", kind: KinshipGrandparent, generation: -2, side: KinshipSidePaternal},
		{name: "child", targetID: "child", title: "Con", kind: KinshipChild, generation: 1, side: KinshipSideUnknown},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			result, err := calculator.Calculate("actor", test.targetID)
			require.NoError(t, err)
			require.Equal(t, test.title, result.Title)
			require.Equal(t, test.kind, result.Kind)
			require.Equal(t, test.generation, result.Generation)
			require.Equal(t, test.side, result.Side)
			require.False(t, result.Ambiguous)
		})
	}
}

func TestKinshipCalculator_MaternalGrandparent(t *testing.T) {
	calculator, err := NewKinshipCalculator([]*Member{
		{ID: "actor", ParentID: "mother"},
		{ID: "mother", ParentID: "grandmother", Gender: "female"},
		{ID: "grandmother", Gender: "female"},
	})
	require.NoError(t, err)

	result, err := calculator.Calculate("actor", "grandmother")

	require.NoError(t, err)
	require.Equal(t, "Bà ngoại", result.Title)
	require.Equal(t, KinshipSideMaternal, result.Side)
}

func TestKinshipCalculator_ParentSiblingTitlesUseSideGenderAndAge(t *testing.T) {
	members := []*Member{
		{ID: "paternal-actor", ParentID: "father"},
		{ID: "father", ParentID: "paternal-root", Gender: "male", BirthDate: "1970-01-01"},
		{ID: "bac", ParentID: "paternal-root", Gender: "female", BirthDate: "1965-01-01"},
		{ID: "chu", ParentID: "paternal-root", Gender: "male", BirthDate: "1975-01-01"},
		{ID: "co", ParentID: "paternal-root", Gender: "female", BirthDate: "1978-01-01"},
		{ID: "maternal-actor", ParentID: "mother"},
		{ID: "mother", ParentID: "maternal-root", Gender: "female", BirthDate: "1970-01-01"},
		{ID: "cau", ParentID: "maternal-root", Gender: "male", BirthDate: "1975-01-01"},
		{ID: "di", ParentID: "maternal-root", Gender: "female", BirthDate: "1978-01-01"},
	}
	calculator, err := NewKinshipCalculator(members)
	require.NoError(t, err)

	tests := []struct {
		actorID string
		target  string
		title   string
		side    KinshipSide
		order   KinshipAgeOrder
	}{
		{actorID: "paternal-actor", target: "bac", title: "Bác", side: KinshipSidePaternal, order: KinshipAgeOlder},
		{actorID: "paternal-actor", target: "chu", title: "Chú", side: KinshipSidePaternal, order: KinshipAgeYounger},
		{actorID: "paternal-actor", target: "co", title: "Cô", side: KinshipSidePaternal, order: KinshipAgeYounger},
		{actorID: "maternal-actor", target: "cau", title: "Cậu", side: KinshipSideMaternal, order: KinshipAgeYounger},
		{actorID: "maternal-actor", target: "di", title: "Dì", side: KinshipSideMaternal, order: KinshipAgeYounger},
	}

	for _, test := range tests {
		t.Run(test.title, func(t *testing.T) {
			result, err := calculator.Calculate(test.actorID, test.target)
			require.NoError(t, err)
			require.Equal(t, test.title, result.Title)
			require.Equal(t, test.side, result.Side)
			require.Equal(t, test.order, result.AgeOrder)
			require.False(t, result.Ambiguous)
		})
	}
}

func TestKinshipCalculator_ResolvesSpouseSideAndMarksAffinity(t *testing.T) {
	calculator, err := NewKinshipCalculator([]*Member{
		{ID: "actor", SpouseID: "spouse", Gender: "male"},
		{ID: "spouse", ParentID: "mother-in-law", SpouseID: "actor", Gender: "female"},
		{ID: "mother-in-law", Gender: "female"},
	})
	require.NoError(t, err)

	result, err := calculator.Calculate("actor", "mother-in-law")

	require.NoError(t, err)
	require.Equal(t, "Mẹ", result.Title)
	require.Equal(t, KinshipParent, result.Kind)
	require.True(t, result.ViaSpouse)
	require.Equal(t, "actor", result.ActorID)
}

func TestKinshipCalculator_MissingAgeUsesExplicitAmbiguousFallback(t *testing.T) {
	calculator, err := NewKinshipCalculator([]*Member{
		{ID: "actor", ParentID: "father"},
		{ID: "father", ParentID: "root", Gender: "male"},
		{ID: "uncle", ParentID: "root", Gender: "male"},
	})
	require.NoError(t, err)

	result, err := calculator.Calculate("actor", "uncle")

	require.NoError(t, err)
	require.Equal(t, "Chú", result.Title)
	require.Equal(t, KinshipAgeUnknown, result.AgeOrder)
	require.True(t, result.Ambiguous)
}

func TestKinshipCalculator_IsDeterministicAndRejectsUnsupportedRelationships(t *testing.T) {
	calculator, err := NewKinshipCalculator([]*Member{
		{ID: "actor"},
		{ID: "unrelated"},
	})
	require.NoError(t, err)

	first, firstErr := calculator.Calculate("actor", "actor")
	second, secondErr := calculator.Calculate("actor", "actor")

	require.NoError(t, firstErr)
	require.NoError(t, secondErr)
	require.Equal(t, first, second)
	_, err = calculator.Calculate("actor", "unrelated")
	require.True(t, errors.Is(err, ErrKinshipNotResolved))
}
