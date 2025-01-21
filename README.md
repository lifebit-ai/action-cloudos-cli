# GitHub Action: Run Lifebit CloudOS jobs with cloudos-cli

This github action uses the [`cloudos-cli`](https://github.com/lifebit-ai/cloudos-cli), the official Lifebit CloudOS API client, to launch jobs programmatically using the `cloudos job run` command.

## Example usage

```yaml
on: [push]

jobs:
  cloudos_job_run:
    runs-on: ubuntu-latest
    name: Submit CloudOS job programmatically
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Echo cloudos command
        uses: lifebit-ai/action-cloudos-cli@0.3.6
        id: cloudos_job_run
        with:
          apikey:  ${{ secrets.CLOUDOS_APIKEY }}
          cloudos_url: 'https://cloudos.lifebit.ai'
          workspace_id: ${{ secrets.CLOUDOS_WORKSPACE_ID }}
          project_name: 'cloudos-cli-tests'
          workflow_name: 'cgpu/rnatoy'
          nextflow_profile: 'test'
          cost_limit: 2
          cloudos_cli_flags: '--resumable'
```


## Inputs

### `dry_run`

If set to `'true'` the action only prints the `cloudos job run` command instead of executing it. Secrets are stripped before printing. This mode can be used for testing.

### `apikey`

The Lifebit CloudOS user personal API token.

> :warning: It is highly recommended to use Github Actions Secrets to define this secret variable. Follow the [official Github Actions documentation for reporsitory secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) to set this up for your reporsitory.


### `cloudos_url`

The Lifebit CloudOS application hostname without a trailing backslash eg https://cloudos.lifebit.ai

### `workspace_id`

The Lifebit CloudOS workspace id. It Can be found under Settings in the web application. It is recommended to use Github Action repository secrets to set up this variable.

### `project_name`

The Lifebit CloudOS workspace id. It can be created and selected from the Lifebit CloudOS web application user interface under Projects.

### `workflow_name`

The Lifebit CloudOS workflow name. It can be created and selected from the Lifebit CloudOS web application user interface under Pipelines & Tools.


### `job_config`

A local file with suffix .config, that includes only a params scope enclosed in curly brackets. The file should contain parameter key:value pairs. For example see: [cloudos/examples/rnatoy.config'](https://github.com/lifebit-ai/cloudos-cli/blob/dev/cloudos/examples/rnatoy.config')


### `nextflow_profile`

One or many comma separated strings, indicating the nextflow profile/s to use with your job. Only applicable to Nextflow workflows.'

### `git_commit`

The exact whole 40 character commit hash to run for the selected pipeline. If not specified it defaults to the last commit of the default branch.

### `git_tag`

The version tag of the chosen workflow repository. It must exist in the repository


### `job_name`

A name to assign to the job run.

### `execution_platform`

Name of the cloud provider used in your CloudOS workspace. Available options: [`aws`, `azure`]. Default: `aws`

### `instance_type`

The type of AWS EC2 instance to use as master node for the job eg c5.xlarge

### `instance_disk`

Disk storage in GB to be used for the master node vm.


### `storage_mode`

The storage mode to use. Available options: [regular,lustre]. Regular is EBS.

### `lustre_size`

The lustre storage to be used when --storage-mode=lustre, in GB. It should be 1200 or a multiple of it.'

### `wait_time`

Max time to wait (in seconds) to job completion

### `wdl_mainfile`

For WDL workflows, which mainFile (.wdl) is configured to use (string). This is defined when the WDL repository is imported under Pipelines & Tools using the Lifebit CloudOS web application user interface.

### `wdl_importsfile`

For WDL workflows, which importsFile (.zip) is configured to use (string). This is defined when the WDL repository is imported under Pipelines & Tools using the Lifebit CloudOS web application user interface.

### `cromwell_token`

Specific Cromwell server authentication token. Only required for WDL jobs.

### `repository_platform`

Name of the repository platform of the workflow. Default=github.

### `job_queue`

Name of the job batch queue to use with a batch job execution. Default: workspace default.

### `cost_limit`

Cost limit in USD. If the job exceeds the defined cost limit, the job will be aborted. :warning: It is advised to always use a cost limit to avoid jobs running indefinitely if there is a pipeline issue.
### `request_interval`

Request interval in seconds. The options is influencing the request interval for receiving the job status when `--wait-completion` is used. The default value is the same as the default of [](https://github.com/lifebit-ai/cloudos-cli).

### `cloudos_cli_flags`

Additional cloudos-cli flags, space separated eg `'--resumable'`. Available options: `[--resumable, --verbose, --wait-completion]`

## Outputs

### `job_id`

Job ID extracted from Lifebit CloudOS cloudos-cli.
