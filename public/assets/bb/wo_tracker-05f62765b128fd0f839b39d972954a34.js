(function(){window.WOTracker={Models:{},Collections:{},Views:{},Routers:{},initialize:function(){var i;return i=new this.Models.Workout}},$.fn.serializeObject=function(){var i,e;return e={},i=this.serializeArray(),$.each(i,function(){return e[this.name]?(e[this.name].push||(e[this.name]=[e[this.name]]),e[this.name].push(this.value||"")):e[this.name]=this.value||""}),e}}).call(this);