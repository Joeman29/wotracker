class WOTracker.Models.Exercise extends Backbone.Model
  defaults: {
    name: 'New Exercise'
  }
  urlRoot: ->
    return '/' unless @collection
    url = @collection.url
    url += @id if @id
    url
  initialize: ->
    @url = ->
      return '/' unless @collection
      url = @collection.url
      url += @id if @id
      url
    @view = new WOTracker.Views.ExerciseView(model: this)
    @on 'change', ->
      @view.render()
      @save()
  displayValue: ->
    value = ''
    kind = @attributes.kind
    return value unless kind
    if kind == 'bodyweight' || kind == 'lifting'
      value += "#{@attributes.sets}X#{@attributes.reps}"
    if kind == 'lifting'
      value += " #{@attributes.weight} #{@attributes.weight_unit}"
    if kind == 'cardio'
      value += "#{@attributes.time} minutes"
    value

