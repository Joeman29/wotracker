class WOTracker.Views.SegmentsIndex extends Backbone.View
  tagName: 'ul'
  template: JST['segments/index']
  events: {
    'sortupdate': 'newSort'
  }
  initialize: ->
    #@collection.on 'reset', @render, this
    @collection.on 'add', @addSegment, this
  render: ->
        $(@el).html(@template())
        for seg in @collection.models
          $(@el).append(seg.view.render().el)
        @$el.sortable()
        @delegateEvents()
        this
  addSegment: (seg)->
    @$el.append(seg.view.render().el)
  newSort: (event, ui)->
    count = 1
    for li in @$el.find("li:not(.jquery-ui-placeholder)")
      position = parseInt($($(li).find(".segment-position")).text())
      segment = @collection.at(position - 1)
      segment.set 'position', count
      count++
    @collection.sort()
    @render()