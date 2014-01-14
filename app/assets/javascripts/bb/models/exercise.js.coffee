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
      @save()
      @view.render()
    @on 'invalid', ->
      @attributes = @previousAttributes()
      alert @validationError
  validate: (attrs, options)->
    if attrs.name.length < 1
      return "Name cannot be blank"
    if @previousAttributes().time && !$.isNumeric(attrs.time)
      return 'Time must be a number'
    if @previousAttributes().weight && !$.isNumeric(attrs.weight)
      return 'Weight must be a number'
    if @previousAttributes().reps && !$.isNumeric(attrs.reps)
      return 'Reps must be a number'

