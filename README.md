# rackspace_anz_dd15demo cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['dd15demo']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### dd15demo::default

Include `dd15demo` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[dd15demo::default]"
  ]
}
```

## Server provisioning

```sh
export OS_AUTH_TOKEN=XXX
supernova anzdevops -x heat stack-create -P organization=anzdevops -P validation_key="$(< ../../../.chef/anzdevops-validator.pem)" -f chef-multi.yaml -P run_list='"recipe[rackops_rolebook]"' -e env-2net.yaml -P resource_count=2 -P prefix=dd15demo-00 dd15demo-00
```

## License and Authors

Author:: YOUR_NAME (<YOUR_EMAIL>)
