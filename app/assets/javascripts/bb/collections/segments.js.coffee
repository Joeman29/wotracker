class WOTracker.Collections.Segments extends Backbone.Collection
  model: WOTracker.Models.Segment
  comparator: 'position'
  initialize: ->
    @view = new WOTracker.Views.SegmentsIndex(collection: this)
    @on 'segment_removed', @fix_positions
  fix_positions: ->
    count = 1
    for segment in @models
      segment.set position:count
      count++
