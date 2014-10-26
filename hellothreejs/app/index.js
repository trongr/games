jQuery(function($){

    var k = {

    }

    var views = (function(){
        var views = {}

        views.init = function(){
            tri.init()
        }

        return views
    }())

    var bindings = (function(){
        var bindings = {}

        bindings.init = function(){
            // $("#newssubscribe").on("click", bindings.subscribe)
        }

        return bindings
    }())

    views.init()
    bindings.init()
});
