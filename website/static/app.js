/* AngularJS */
var app = angular.module("myApp", ['ui.router']);

// Change Interpolation from {{ }} to [[ ]]
app.config(function($interpolateProvider){
    $interpolateProvider.startSymbol('[[');
    $interpolateProvider.endSymbol(']]');
});

// Routing
app.config(['$stateProvider', '$urlRouterProvider', '$locationProvider',
    function($stateProvider, $urlRouterProvider, $locationProvider){
        // Bad Url
        $urlRouterProvider.otherwise(function($injector, $location){
            var state = $injector.get('$state');
            state.go('404');
            return $location.path();
        });

        $stateProvider.
            state('home', {
                data : { pageTitle : 'Homepage'},
                templateUrl : 'static/angular_partials/home.html',
                url : '/'
            }).
            state('test', {
                data : { pageTitle : 'Test Page'},
                template : '<h1>Tesing...</h1>',
                url : '/test'
            }).
            state('404', {
                data : { pageTitle : 'Error 404'},
                template : 'error 404',
            });

            $locationProvider.html5Mode(true);
}]);

// Modify Page Title Based on Route
app.run(['$rootScope', '$state', '$stateParams',
    function($rootScope, $state, $stateParams) {
        $rootScope.$state = $state;
        $rootScope.$stateParams = $stateParams;
}]);