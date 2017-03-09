class Dashing.icinga_hosts_services extends Dashing.Widget
  @accessor 'hosts_up_value', Dashing.AnimatedValue
  @accessor 'hosts_unknown_value', Dashing.AnimatedValue
  @accessor 'hosts_warning_value', Dashing.AnimatedValue
  @accessor 'hosts_critical_value', Dashing.AnimatedValue
  @accessor 'services_up_value', Dashing.AnimatedValue
  @accessor 'services_unknown_value', Dashing.AnimatedValue
  @accessor 'services_warning_value', Dashing.AnimatedValue
  @accessor 'services_critical_value', Dashing.AnimatedValue

  constructor: ->
    super

  onData: (data) ->

    node = $(@node)
    hosts_critical_value = parseInt data.hosts_critical_value
    hosts_unknown_value = parseInt data.hosts_unknown_value
    hosts_warning_value = parseInt data.hosts_warning_value
    hosts_up_value = parseInt data.hosts_up_value
    services_critical_value = parseInt data.services_critical_value
    services_unknown_value = parseInt data.services_unknown_value
    services_warning_value = parseInt data.services_warning_value
    services_up_value = parseInt data.services_up_value

    if hosts_critical_value > 0
      widgetcolor = 'status_critical'
    else if hosts_warning_value > 0
      widgetcolor = 'status_warning'
    else if hosts_unknown_value > 0
      widgetcolor = 'status_unknown'
    else
      widgetcolor = 'status_up'
    if services_critical_value > 0
      widgetcolor = 'status_critical'
    else if services_warning_value > 0
      widgetcolor = 'status_warning'
    else if services_unknown_value > 0
      widgetcolor = 'status_unknown'
    else
      widgetcolor = 'status_up'

    backgroundClass = "#{widgetcolor}"
    lastClass = @get "lastClass"
    node.toggleClass "#{lastClass} #{backgroundClass}"
    @set "lastClass", backgroundClass


