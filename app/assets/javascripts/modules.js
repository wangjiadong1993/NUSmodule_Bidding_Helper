var app = angular.module('modules', []);
app.controller('controller', function($scope, modulegetter) {
	$scope.namespace = {}
	$scope.namespace.test = "wangjiadong"
	$scope.namespace.modules = []
	$scope.namespace.day_init = [null,null,null,null,null,null,null,null,null,null,null,null,null,null];
	$scope.namespace.week_init = [$scope.namespace.day_init,$scope.namespace.day_init,$scope.namespace.day_init,$scope.namespace.day_init,$scope.namespace.day_init]
	$scope.namespace.add_module = function() {
		modulegetter.coder($scope.namespace.input).success(function(data){
			console.log(data)
			if(data.status == 1 && $scope.namespace.repeatcheck(data.module.code)){
				$scope.namespace.modules.push(data)
				arrange(0, $scope.namespace.week_init)
				console.log($scope.namespace.modules)
			}
		}).error(function(){

		})
	}
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

	function arrange(start_id, week_init) {
		// console.log("hello dude called")
		// var workload = $scope.namespace.modules[start_id]['module']['workload']
		// var lec = workload.match(/\d+/)
		// var tut = workload.match(/\d+/)
		// var lab = workload.match(/\d+/)
		// if(start_id == $scope.namepsace.length-1){

		// }else{

		// }
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

