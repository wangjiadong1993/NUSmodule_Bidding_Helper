var app = angular.module('modules', []);
app.controller('controller', function($scope, modulegetter, bidgetter) {
	$scope.namespace = {}
	$scope.namespace.test = "wangjiadong"
	$scope.namespace.time_comp_const = ["Earlier Than", "Later Than", "No Between", "Between"]
	$scope.namespace.week_code_const = ["All","Mon", "Tue", "Wed", "Thu", "Fri"]
	$scope.namespace.time_code_const = [800,830,900,930,1000,1030,1100,1130,1200,1230,1300,1330,1400,1430,1500,1530,1600,1630,1700,1730,1800,1830,1900,1930,2000,2030,2100,2130,2200]
	$scope.namespace.modules = [] //all the modules
	$scope.namespace.solutions = []
	$scope.namespace.time_filter = []
	$scope.namespace.lesson_filter = []
	$scope.namespace.one_solution =[]
	$scope.namespace.solution_chosen_index = 0
	$scope.namespace.timetable = []
	// $scope.namespace.day_init = [0,0,0,0,null,null,null,null,null,null,null,null,null,null];
	// $scope.namespace.week_init = [$scope.namespace.day_init,$scope.namespace.day_init,$scope.namespace.day_init,$scope.namespace.day_init,$scope.namespace.day_init]
	$scope.namespace.add_module = function() {
		modulegetter.coder($scope.namespace.input).success(function(data){
			console.log(data)
			if(data.status == 1 && $scope.namespace.repeatcheck(data.module.code)){
				$scope.namespace.modules.push(data)
				// arrange(0, $scope.namespace.week_init)
				console.log($scope.namespace.modules)
			}
		}).error(function(){

		})
	}
	$scope.namespace.time_filter_generate = function (){
		// console.log("hello")
		var temp ={}
		temp['daycode'] = "Wed";
		temp['comparison'] = "Earlier Than";
		temp['timecode_1'] = 8;
		temp['timecode_2'] = 8;
		$scope.namespace.time_filter.push(temp)

	}
	$scope.namespace.lesson_filter_generate = function (){
		// console.log("hello")
		var temp ={}
		temp['modulecode'] = "Wed";
		temp['timeslot'] = "Earlier Than";
		// temp['timecode_1'] = 8;
		// temp['timecode_2'] = null;
		$scope.namespace.lesson_filter.push(temp)

	}
	$scope.$watch("namesapce.lesson_filter", function(){
		console.log($scope.namespace.lesson_filter)
	})
	$scope.namespace.repeatcheck = function(code) {
		len = $scope.namespace.modules.length;
		if(len==0){
			return 1;
		}else {
			for(i=0; i<len; i++){
				if (code == $scope.namespace.modules[i].module.code){
					return 0;
				}
			}
			return 1;
		}
	}

	$scope.namespace.click_cal = function() {
		$scope.namespace.solution_chosen_index = 0
		bidgetter.coder($scope.namespace.input).success(function(data){
			console.log(data)
		}).error(function(){

		})
		if( $scope.namespace.modules.length != 0  && $scope.namespace.modules.length < 10){
			$scope.namespace.solutions = $scope.namespace.calculate($scope.namespace.modules)
		}
	}
	$scope.$watch("namespace.solution_chosen_index", function(){
		// if($scope.namespace.solution_chosen_index != null )
		var a = $scope.namespace.solution_chosen_index
		if (a >= 0 && a != null && $scope.namespace.solutions.length != 0){
			var b = $scope.namespace.solutions[a]
			var c = b.length
			for (var swnsi = 0 ; swnsi < c; swnsi++){
				var m = b[swnsi]['starttime']
			}
		}
	})

	$scope.namespace.calculate  = function(nus_modules) {
		// console.log("already in the calculate method")
		if (nus_modules.length == 1){
			// console.log("time to go out of calculate method")
			// console.log(nus_modules[0]['combination'].length)
			return nus_modules[0]['combination']==[] ? null : nus_modules[0]['combination'][0]
		}else {
			// var modules_copy = nus_modules
			var last  = nus_modules[nus_modules.length-1]['combination']
			var combi = $scope.namespace.calculate(nus_modules.slice(0, nus_modules.length-1))
			var solutions = []
			console.log(last.length +"  "+combi.length)
			if(combi == []){
				return (last==[] ? null : last[0])
			}else if (last ==[]){
				return (combi=[] ? null : combi[0])
			}else{
				for(i=0; i<last.length;i++){
					for(j=0;j<combi.length;j++){
						console.log("iteration method  "+i + " "+j)
						var tmp = combine_check_repeat(last[i], combi[j])
						if (tmp != null){
							solutions.push(tmp)
						}
					}
				}
				console.log("out iteration")
				return solutions
			}
		}
	}
	function combine_check_repeat(slot, table){
		// return null;
		var i = 0;
		var j = 0;
		for(i=0; i< table.length; i++){
			for(j=0; j< slot.length; j++){
				var a_start = slot[j]['starttime']
				var a_length = slot[j]['endtime']-slot[j]['starttime']
				var b_start = table[i]['starttime']
				var b_length = table[i]['endtime']-table[i]['starttime']
				var c_start = a_start
				var c_length = a_length
				if(a_start == b_start)
				{
					return null
				}else{
					if(a_start > b_start){
						a_start = b_start
						b_start = c_start

						a_length = b_length
						b_length = c_length
					}
					if(b_start < a_start+a_length){
						return null
					}

				}
			}
			return table.concat(slot)
		}
	}
})
app.factory('modulegetter', function($http) {
	return {
		getter: function(objid){
				return $http.get('/modules/mod_info/'+objid)
			},
	coder: function(objcode){
		       return $http.get('/modules/code_info/'+objcode)
	       }
	}
})

app.factory('bidgetter', function($http) {
	return {
		getter: function(objid){
				return $http.get('/modules/mod_info/'+objid)
			},
	coder: function(objcode){
		       return $http.get('/bid/show_code/'+objcode)
	       }
	}
})
