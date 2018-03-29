import sys
import os

from pybuilder.core import init, use_plugin

# Define plugins
use_plugin("python.core")
use_plugin("python.unittest")
use_plugin("python.coverage")
use_plugin("python.install_dependencies")
use_plugin("python.distutils")
# use_plugin("python.sonarqube")

# Define project variables
# default_task = ['clean', 'analyze', 'run_sonar_analysis', 'publish']
default_task = ['clean', 'analyze', 'publish']
name = "hello_world_flask"
version = '0.0.1.0'


@init
def initialize(project):
    sys.path.append(os.getcwd())

    project.depends_on_requirements("requirements.txt")
    project.build_depends_on('coverage')

    project.set_property('sonarqube_project_key', 'hello_workd_flask')
    project.set_property('sonarqube_project_name', 'hello_workd_flask')

    set_project_properties(project)
    set_unit_tests_properties(project)


def set_unit_tests_properties(project):
    # Ref : http://pybuilder.github.io/documentation/plugins.html#QAplugins

    # Directory where unittest modules are located.
    # Default - 'src/unittest/python'
    # project.set_property('dir_source_unittest_python', 'src/unittest/python')

    # Output teamcity service messages with test names and errors.
    # Default - False
    project.set_property('teamcity_output', True)

    # Pattern used to filter Python modules that should be imported by the unittest runner.
    # Default - *_tests
    project.set_property('unittest_module_glob', '*_tests')

    # This allows you to define how the module unittest identifies tests.
    # The plugin sets defaultTestLoader.testMethodPrefix to the given value.
    # When set to None the plugin will not set the value at all.
    # Default - None
    # project.set_property('unittest_test_method_prefix', 'test_*')

    # Warn if the overall coverage drops below this threshold.
    # Default - 70
    project.set_property('coverage_threshold_warn', 80)

    # Warn if the branch coverage drops below this threshold..
    # Default - 0
    # project.set_property('coverage_branch_threshold_warn', 0)

    # Warn if the branch partial coverage drops below this threshold.
    # Default - 0
    # project.set_property('coverage_branch_partial_threshold_warn', 0)

    # Break the build (i.e. fail it) if the coverage is below the given threshold.
    # Default - True
    project.set_property('coverage_break_build', True)

    # Allow modules which were not imported by the covered tests.
    # Default - True
    # project.set_property('coverage_allow_non_imported_modules', True)

    # Reset imported modules before coverage.
    # Default - False
    # project.set_property('coverage_reset_modules', False)

    # List of package names to exclude from coverage analyzation.
    # Default - []
    project.set_property('coverage_exceptions', ['__init__'])


def set_project_properties(project):
    # Project version - x.x.x.x. : major_release.feature.qa_release.hot_fix
    project.version = version

    # Project name
    project.name = name

    # Directory where source modules are located.
    # Default - 'src/main/python'
    # project.set_property('dir_source_main_python', 'src/main/python')
