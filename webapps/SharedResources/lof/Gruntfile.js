'use strict';

module.exports = function(grunt) {

	grunt.initConfig({
		cssFiles : [],
		jsFiles : ['js/src/nb.js', 'js/src/*.js', ],
		jsBuildFile : 'js/nb.build.js',
		pkg : grunt.file.readJSON('package.json'),
		cssmin : {
			compress : {
				files : {
					'css/all.min.css' : '<%= cssFiles %>'
				}
			}
		},
		jshint : {
			allFiles : '<%= jsBuildFile %>',
			options : {
				curly : true,
				eqeqeq : true,
				immed : false,
				latedef : true,
				newcap : true,
				noarg : true,
				sub : true,
				undef : true,
				boss : true,
				eqnull : true
			}
		},
		concat : {
			options : {
				banner : "/* склеено с Grunt */\n\n"
			},
			main : {
				src : '<%= jsFiles %>',
				dest : '<%= jsBuildFile %>'
			}
		},
		uglify : {
			main : {
				files : {
					'js/nb.min.js' : '<%= concat.main.dest %>'
				}
			}
		},
		watch : {
			files : ['<%= cssFiles %>', '<%= jsFiles %>'],
			tasks : ['concat']
		}
	});

	grunt.loadNpmTasks('grunt-contrib-cssmin');
	grunt.loadNpmTasks('grunt-contrib-jshint');
	grunt.loadNpmTasks('grunt-contrib-concat');
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-watch');

	grunt.registerTask('default', ['concat', 'watch']);
};
