(function(){this.JST||(this.JST={}),this.JST["workouts/index"]=function(e){e||(e={});var n,t=[],a=function(e){return e&&e.ecoSafe?e:"undefined"!=typeof e&&null!=e?s(e):""},o=e.safe,s=e.escape;return n=e.safe=function(e){if(e&&e.ecoSafe)return e;("undefined"==typeof e||null==e)&&(e="");var n=new String(e);return n.ecoSafe=!0,n},s||(s=e.escape=function(e){return(""+e).replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/"/g,"&quot;")}),function(){(function(){t.push('<h2><span class="editable" data-workout="name">'),t.push(a(this.workout.name)),t.push('</span> -- <span class="editable" data-workout="goal_time">'),t.push(a(this.workout.goal_time)),t.push('</span> min.</h2>\n<div id="workout-display"></div>\n<button class="new-segment">New Workout Section</button>\n\n')}).call(this)}.call(e),e.safe=o,e.escape=s,t.join("")}}).call(this);