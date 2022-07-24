#!/bin/bash
set -e

// [CLOUDOS CMD]
CLOUDOS_RUN_CMD = "cloudos job run"
CLOUDOS_RUN_CMD += " --apikey ${INPUT_APIKEY}"
CLOUDOS_RUN_CMD += " --cloudos-url ${INPUT_CLOUDOS_URL}"
CLOUDOS_RUN_CMD += " --workspace-id ${INPUT_WORKSPACE_ID}"
CLOUDOS_RUN_CMD += " --project-name ${INPUT_PROJECT_NAME}"
CLOUDOS_RUN_CMD += " --workflow-name ${INPUT_WORKFLOW_NAME}"
CLOUDOS_RUN_CMD += " --job-config ${INPUT_JOB_CONFIG}"
CLOUDOS_RUN_CMD += " --nextflow-profile ${INPUT_NEXTFLOW_PROFILE}"
CLOUDOS_RUN_CMD += " --git-commit ${INPUT_GIT_COMMIT}"
CLOUDOS_RUN_CMD += " --git-tag ${INPUT_GIT_TAG}"
CLOUDOS_RUN_CMD += " --job-name ${INPUT_JOB_NAME}"
CLOUDOS_RUN_CMD += " --instance-type ${INPUT_INSTANCE_TYPE}"
CLOUDOS_RUN_CMD += " --instance-disk ${INPUT_INSTANCE_DISK}"
CLOUDOS_RUN_CMD += " --storage-mode ${INPUT_STORAGE_MODE}"
CLOUDOS_RUN_CMD += " --lustre-size ${INPUT_LUSTRE_SIZE}"
CLOUDOS_RUN_CMD += " --wait-time ${INPUT_WAIT_TIME}"
CLOUDOS_RUN_CMD += " --wdl-mainfile ${INPUT_WDL_MAINFILE}"
CLOUDOS_RUN_CMD += " --wdl-importsfile ${INPUT_WDL_IMPORTSFILE}"
CLOUDOS_RUN_CMD += " --cromwell-token ${INPUT_CROMWELL_TOKEN}"
CLOUDOS_RUN_CMD += " --repository-platform ${INPUT_REPOSITORY_PLATFORM}"
CLOUDOS_RUN_CMD += " ${INPUT_CLOUDOS_CLI_FLAGS}"

echo $CLOUDOS_RUN_CMD

echo "::set-output name=cloudos_run_cmd::$CLOUDOS_RUN_CMD"