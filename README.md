## Icinga widget for Dashing
Dashing widget to display all hosts and services status for a defined hostgroup. The widget color changes if any host or service changes state.

## Configuration
*This widget depends on the Icinga Web api version 1!*

To configure this widget, you need to edit the jobs/icinga_hosts_services_customer1.rb file and set the variables as mentioned below.

* _ICINGA_WEB_API_PATH = " icinga-web-api-url "
* _ICINGA_HOSTGROUP = " host group name "
* _CUSTOMER_CODE = "customer1"
* _ICINGA_AUTH_KEY = " icinga-web-api-auth_key "

You can also configure the overall widget coloring in the file widgets/icinga_hosts_services/colors.scss

## Preview

![](https://github.com/mboogert/dashing-icinga-hostgroup-status/blob/master/preview-green.png)
