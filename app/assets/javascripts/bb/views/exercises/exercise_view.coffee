class WOTracker.Views.ExerciseView extends Backbone.View
  tagName: 'tr'
  template: JST['exercises/exercise']
  exerciseFormTemplate: JST['exercises/form']
  events:
    'submit '   : 'changeDesc'
    'click .edit-exercise': 'edit_exercise'
    'click .delete-exercise': 'delete_exercise'
    'click .cancel-exercise-edit': 'cancel_edit'
    'click .exercise-promote': 'promote'
    'change select, input': 'changeValue'
    'dblclick .exercise-name': 'showEditName'
  render: ->
    seg = @model.collection.parent
    sets = seg.get 'sets' if seg
    attrs = $.extend(@model.attributes, {sets: sets})
    $(@el).html(@template(attrs))
    $(@el).find('select[name=kind]').val(@model.attributes.kind)
    sels = $(@el).find('.kind').find(':selected').data('selectors')
    @delegateEvents()
    return this unless sels
    spans = @$el.find('.hideable')
    spans.find(sels).show()
    spans.children().not(sels).hide()
    this
  edit_exercise: (e)->
    @$el.remove("#exercise-form")
    @$el.append(@exerciseFormTemplate(@model.attributes, formName:'Edit Form'))
    form = @$el.find('#exercise-form')
    values = {
      top: $(e.target).offset().top
      left: $(e.target).offset().left - form.outerWidth()/2
    }
    form.css(values)
    form.fadeIn()
  changeDesc: (e)->
    e.preventDefault()
    @model.set $(e.target).serializeObject()
    @$el.find("#exercise-form").fadeOut()
  delete_exercise:->
   if confirm "Are you sure you want to remove #{@model.attributes.name}?\n You cannot undo this action."
    exercises = @model.collection
    @model.destroy()
    @$el.remove()
    exercises.trigger('exercise_removed')
  cancel_edit:->
    @$el.find("#exercise-form").fadeOut()
  showEditName: ->
    @$el.find('.exercise-name').hide()
    @$el.find('.exercise-name-edit').show()
  changeValue:(e)->
    newVal = $(e.target).val()
    @model.set $(e.target).attr('name'), newVal