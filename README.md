# ssh-deploy-action

This action deploys latest docker image to a remote server via SSH.

## Usage

```yaml
steps:
  - uses: hantastic3/ssh-deploy-action@v1.1.0
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
```

Or pass a single `repository_uri` instead of `registry` and `repository`:

```yaml
steps:
  - uses: hantastic3/ssh-deploy-action@v1.1.0
    with:
      host: ${{ secrets.HOST }}
      username: ${{ secrets.USERNAME }}
      ssh_key: ${{ secrets.SSH_KEY }}
      repository_uri: registry.example.com/my-org/my-app
      image_tag: ${{ github.ref_name }}
      working_directory: /srv/my-app
```

Provider selection is automatic:
- `*.aliyuncs.com` uses the Aliyun deploy script.
- Other registries use the AWS/ECR deploy script.
