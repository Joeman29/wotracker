class WOTracker.Views.SegmentView extends Backbone.View
  tagName: 'li'
  class: 'segment-edit'
  template: JST['segments/segment']
  events:
    'dblclick .segment-name': 'showSegmentNameEdit'
    'change .segment-value-edit': 'change_value'
    'click .new-exercise' : 'new_exercise'
    'click .delete-segment': 'delete_segment'
    'click .segment-promote': 'promote'
    'change select[name=sets]': 'changeSets'
  render: ->
    @$el.html(@template(@model.attributes))
    sets = @model.attributes.sets
    @$el.find('select[name=sets]').val(sets)
    @$el.find('.segment-table').append(@model.exercises.view.render().el)
    @delegateEvents()
    this
  new_exercise: ->
    newEx = @model.exercises.create({name: 'New Exercise'})
    @model.exercises.add newEx
  delete_segment: ->
   if confirm("Are you sure you want to remove this section?\n You cannot undo this action.")
      segments = @model.collection
      @model.destroy()
      @$el.remove()
      segments.trigger 'segment_removed'
  showSegmentNameEdit: (e)->
    @$el.find('input[name=name].segment-value-edit').show()
    @$el.find('.segment-name').hide()
  change_value: (e)->
    @model.set $(e.target).attr('name'), $(e.target).val()
  changeSets:(e)->
    newVal = parseInt($(e.target).val())
    @model.set 'sets', newVal