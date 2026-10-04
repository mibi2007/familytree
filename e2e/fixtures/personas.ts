export const personas = {
  owner: {
    email: 'owner@familytree.e2e',
    password: 'OwnerPass123!',
    displayName: 'E2E Owner',
    role: 'USER',
  },
  member: {
    email: 'member@familytree.e2e',
    password: 'MemberPass123!',
    displayName: 'E2E Member',
    role: 'USER',
  },
  secondMember: {
    email: 'second-member@familytree.e2e',
    password: 'SecondMemberPass123!',
    displayName: 'E2E Second Member',
    role: 'USER',
  },
  admin: {
    email: 'binhhm2009@gmail.com',
    password: 'AdminPass123!',
    displayName: 'E2E Root Admin',
    role: 'SUPER_ADMIN',
  },
  pendingAdmin: {
    email: 'pending-admin@familytree.e2e',
    password: 'PendingPass123!',
    displayName: 'E2E Pending Admin',
    role: 'USER',
  },
  rejectedAdmin: {
    email: 'rejected-admin@familytree.e2e',
    password: 'RejectedPass123!',
    displayName: 'E2E Rejected Admin',
    role: 'USER',
  },
  revocableAdmin: {
    email: 'revocable-admin@familytree.e2e',
    password: 'RevocablePass123!',
    displayName: 'E2E Revocable Admin',
    role: 'SUPER_ADMIN',
  },
  onboardingPending: {
    email: 'onboarding-pending@familytree.e2e',
    password: 'OnboardingPending123!',
    displayName: 'E2E Onboarding Pending',
    role: 'USER',
  },
  onboardingRejected: {
    email: 'onboarding-rejected@familytree.e2e',
    password: 'OnboardingRejected123!',
    displayName: 'E2E Onboarding Rejected',
    role: 'USER',
  },
  onboardingApplicant: {
    email: 'onboarding-applicant@familytree.e2e',
    password: 'OnboardingApplicant123!',
    displayName: 'E2E Onboarding Applicant',
    role: 'USER',
  },
} as const;

export type PersonaName = keyof typeof personas;
