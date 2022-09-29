#!/bin/bash
set -e

CLOUDOS_RUN_CMD="cloudos job run"

CLOUDOS_RUN_CMD+=" --apikey ${INPUT_APIKEY}"
CLOUDOS_RUN_CMD+=" --cloudos-url ${INPUT_CLOUDOS_URL}"
CLOUDOS_RUN_CMD+=" --workspace-id ${INPUT_WORKSPACE_ID}"
CLOUDOS_RUN_CMD+=" --project-name ${INPUT_PROJECT_NAME}"
CLOUDOS_RUN_CMD+=" --workflow-name ${INPUT_WORKFLOW_NAME}"

if [[ ${INPUT_JOB_CONFIG} ]];          then CLOUDOS_RUN_CMD+=" --job-config ${INPUT_JOB_CONFIG}" ; fi
if [[ ${INPUT_NEXTFLOW_PROFILE} ]];    then CLOUDOS_RUN_CMD+=" --nextflow-profile ${INPUT_NEXTFLOW_PROFILE}" ; fi
if [[ ${INPUT_GIT_COMMIT} ]];          then CLOUDOS_RUN_CMD+=" --git-commit ${INPUT_GIT_COMMIT}" ; fi
if [[ ${INPUT_GIT_TAG} ]];             then CLOUDOS_RUN_CMD+=" --git-tag ${INPUT_GIT_TAG}" ; fi
if [[ ${INPUT_JOB_NAME} ]];            then CLOUDOS_RUN_CMD+=" --job-name ${INPUT_JOB_NAME}" ; fi
if [[ ${INPUT_INSTANCE_TYPE} ]];       then CLOUDOS_RUN_CMD+=" --instance-type ${INPUT_INSTANCE_TYPE}" ; fi
if [[ ${INPUT_INSTANCE_DISK} ]];       then CLOUDOS_RUN_CMD+=" --instance-disk ${INPUT_INSTANCE_DISK}" ; fi
if [[ ${INPUT_STORAGE_MODE} ]];        then CLOUDOS_RUN_CMD+=" --storage-mode ${INPUT_STORAGE_MODE}" ; fi
if [[ ${INPUT_LUSTRE_SIZE} ]];         then CLOUDOS_RUN_CMD+=" --lustre-size ${INPUT_LUSTRE_SIZE}" ; fi
if [[ ${INPUT_WAIT_TIME} ]];           then CLOUDOS_RUN_CMD+=" --wait-time ${INPUT_WAIT_TIME}" ; fi
if [[ ${INPUT_WDL_MAINFILE} ]];        then CLOUDOS_RUN_CMD+=" --wdl-mainfile ${INPUT_WDL_MAINFILE}" ; fi
if [[ ${INPUT_WDL_IMPORTSFILE} ]];     then CLOUDOS_RUN_CMD+=" --wdl-importsfile ${INPUT_WDL_IMPORTSFILE}" ; fi
if [[ ${INPUT_CROMWELL_TOKEN} ]];      then CLOUDOS_RUN_CMD+=" --cromwell-token ${INPUT_CROMWELL_TOKEN}" ; fi
if [[ ${INPUT_REPOSITORY_PLATFORM} ]]; then CLOUDOS_RUN_CMD+=" --repository-platform ${INPUT_REPOSITORY_PLATFORM}" ; fi
if [[ ${INPUT_CLOUDOS_CLI_FLAGS} ]];   then CLOUDOS_RUN_CMD+=" ${INPUT_CLOUDOS_CLI_FLAGS}" ; fi

if [[ ${INPUT_DRY_RUN} != 'true' ]]
then
    stdout=$($CLOUDOS_RUN_CMD)
    echo $stdout

    jobidWithSpace=$(awk -F"Your assigned job id is: |Please, wait until job completion or max wait time of 3600 seconds is reached." '{print $2}' <<< "$stdout")
    jobid=$(echo $jobidWithSpace | tr -d '\r' | tr -d '\n')
else
    stdout="No job was run"
    jobid=""
fi

echo "::set-output name=stdout::$stdout"
echo "::set-output name=jobid::$jobid"