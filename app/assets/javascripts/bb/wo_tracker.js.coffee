window.WOTracker =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
      wo_model = new @Models.Workout()





$.fn.serializeObject = ->
  o = {}
  a = this.serializeArray();
  $.each a, ->
    if (o[this.name])
      if (!o[this.name].push)
        o[this.name] = [o[this.name]]
      o[this.name].push(this.value || '');
    else
      o[this.name] = this.value || '';
  o
