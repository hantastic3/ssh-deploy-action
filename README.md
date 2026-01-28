# ssh-deploy-action

This action deploys latest docker image to a remote server via SSH.

## Usage

```yaml
steps:
  - uses: zebbie-ai/ssh‑deploy-action@v1
    with:
      host: ${{ secrets.HOST }}
      username: ${{ secrets.USERNAME }}
      ssh_key: ${{ secrets.SSH_KEY }}
      registry: ${{ secrets.REGISTRY }}
      repository: ${{ secrets.REPOSITORY }}
      image_tag: ${{ github.ref_name }}
      aliyun_username: ${{ secrets.ALIYUN_USER }} # if you are using aliyun registry
      aliyun_password: ${{ secrets.ALIYUN_PASS }}
      working_directory: /srv/my-app
      compose_up_args: "--scale bot-mqtt=2 -d"
