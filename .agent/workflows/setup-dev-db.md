# Setup Database Infrastructure (Shared VM)

This workflow guides you through provisioning the shared PostgreSQL VM on Google Cloud for both **Prod** and **Dev** environments.

## Prerequisites
1. **Google Cloud SDK**:
   - Project: `familytree-db-all`
   - APIs Enabled: `compute.googleapis.com`, `storage.googleapis.com` (for backups).
2. **Permissions**: `compute.instances.create`, `storage.buckets.create`.

## Steps

1. **Provision VM**:
   ```bash
   ./scripts/infra/provision_db_vm.sh familytree-db-all asia-southeast1-a <PROD_PASS> <DEV_PASS>
   ```

2. **Verify Databases**:
   SSH into the VM:
   ```bash
   gcloud compute ssh familytree-db-main --project=familytree-db-all --zone=asia-southeast1-a
   # Inside VM:
   sudo -u postgres psql -l
   # Should see: family_tree_prod, family_tree_dev
   ```

3. **Backup Setup (One-time)**:
   Create the GCS buckets for backups:
   ```bash
   gcloud storage buckets create gs://familytree-backups-prod --project=familytree-db-all --location=ASIA
   gcloud storage buckets create gs://familytree-backups-dev --project=familytree-db-all --location=ASIA
   ```

4. **Connection**:
   - **Host**: `<External IP>`
   - **Dev**: User `dev_user`, DB `family_tree_dev`
   - **Prod**: User `prod_user`, DB `family_tree_prod`
