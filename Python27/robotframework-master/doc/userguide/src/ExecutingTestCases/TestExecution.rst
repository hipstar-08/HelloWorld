Test execution
--------------

This section describes how the test suite structure created from the parsed
test data is executed, how to continue executing a test case after failures,
and how to stop the whole test execution gracefully.

.. contents::
   :depth: 2
   :local:

Execution flow
~~~~~~~~~~~~~~

Executed suites and tests
'''''''''''''''''''''''''

Test cases are always executed within a test suite. A test suite
created from a `test case file`_ has tests directly, whereas suites
created from directories__ have child test suites which either have
tests or their own child suites. By default all the tests in an
executed suite are run, but it is possible to `select tests`__ using
options :opt:`--test`, :opt:`--suite`, :opt:`--include` and
:opt:`--exclude`. Suites containing no tests are ignored.

The execution starts from the top-level test suite. If the suite has
tests they are executed one-by-one, and if it has suites they are
executed recursively in depth-first order. When an individual test
case is executed, the keywords it contains are run in a
sequence. Normally the execution of the current test ends if any
of the keywords fails, but it is also possible to
`continue after failures`__. The exact `execution order`_ and how
possible `setups and teardowns`_ affect the execution are discussed
in the following sections.

__ `Test suite directories`_
__ `Selecting test cases`_
__ `Continue on failure`_


Setups and teardowns
''''''''''''''''''''

Setups and teardowns can be used on `test suite`__, `test case`__ and
`user keyword`__ levels.

__ `Test setup and teardown`_
__ `Suite setup and teardown`_
__ `User keyword teardown`_

Suite setup
```````````

If a test suite has a setup, it is executed before its tests and child
suites. If the suite setup passes, test execution continues
normally. If it fails, all the test cases the suite and its child
suites contain are marked failed. The tests and possible suite setups
and teardowns in the child test suites are not executed.

Suite setups are often used for setting up the test environment.
Because tests are not run if the suite setup fails, it is easy to use
suite setups for verifying that the environment is in state in which the
tests can be executed.

Suite teardown
``````````````

If a test suite has a teardown, it is executed after all its test
cases and child suites. Suite teardowns are executed regardless of the
test status and even if the matching suite setup fails. If the suite
teardown fails, all tests in the suite are marked failed afterwards in
reports and logs.

Suite teardowns are mostly used for cleaning up the test environment
after the execution. To ensure that all these tasks are done, `all the
keywords used in the teardown are executed`__ even if some of them
fail.

__ `Continue on failure`_

Test setup
``````````

Possible test setup is executed before the keywords of the test case.
If the setup fails, the keywords are not executed. The main use
for test setups is setting up the environment for that particular test
case.

Test teardown
`````````````

Possible test teardown is executed after the test case has been
executed. It is executed regardless of the test status and also
if test setup has failed.

Similarly as suite teardown, test teardowns are used mainly for
cleanup activities. Also they are executed fully even if some of their
keywords fail.

Keyword teardown
````````````````

`User keywords`_ cannot have setups, but they can have teardowns that work
exactly like other teardowns. Keyword teardowns are run after the keyword is
executed otherwise, regardless the status, and they are executed fully even
if some of their keywords fail.

Execution order
'''''''''''''''

Test cases in a test suite are executed in the same order as they are defined
in the test case file. Test suites inside a higher level test suite are
executed in case-insensitive alphabetical order based on the file or directory
name. If multiple files and/or directories are given from the command line,
they are executed in the order they are given.

If there is a need to use certain test suite execution order inside a
directory, it is possible to add prefixes like :path:`01` and
:path:`02` into file and directory names. Such prefixes are not
included in the generated test suite name if they are separated from
the base name of the suite with two underscores::

   01__my_suite.html -> My Suite
   02__another_suite.html -> Another Suite

If the alphabetical ordering of test suites inside suites is
problematic, a good workaround is giving them separately in the
required order. This easily leads to overly long start-up commands,
but `argument files`_ allow listing files nicely one file per line.

It is also possible to `randomize the execution order`__ using
the :opt:`--randomize` option.

__ `Randomizing execution order`_

Passing execution
'''''''''''''''''

Typically test cases, setups and teardowns are considered passed if
all keywords they contain are executed and none of them fail. From
Robot Framework 2.8 onwards, it is also possible to use BuiltIn_ keywords
:name:`Pass Execution` and :name:`Pass Execution If` to stop execution with
PASS status and skip the remaining keywords.

How :name:`Pass Execution` and :name:`Pass Execution If` behave
in different situations is explained below:

- When used in any `setup or teardown`__ (suite, test or keyword), these
  keywords pass that setup or teardown. Possible teardowns of the started
  keywords are executed. Test execution or statuses are not affected otherwise.

- When used in a test case outside setup or teardown, the keywords pass that
  particular test case. Possible test and keyword teardowns are executed.

- Possible `continuable failures`__ that occur before these keyword are used,
  as well as failures in teardowns executed afterwards, will fail the execution.

- It is mandatory to give an explanation message
  why execution was interrupted, and it is also possible to
  modify test case tags. For more details, and usage examples, see the
  `documentation of these keywords`__.

Passing execution in the middle of a test, setup or teardown should be
used with care. In the worst case it leads to tests that skip all the
parts that could actually uncover problems in the tested application.
In cases where execution cannot continue do to external factors,
it is often safer to fail the test case and make it `non-critical`__.

__ `Setups and teardowns`_
__ `Continue on failure`_
__ `BuiltIn`_
__ `Setting criticality`_

Continue on failure
~~~~~~~~~~~~~~~~~~~

Normally test cases are stopped immediately when any of their keywords
fail. This behavior shortens test execution time and prevents
subsequent keywords hanging or otherwise causing problems if the
system under test is in unstable state. This has the drawback that often
subsequent keywords would give more information about the state of the
system.

Before Robot Framework 2.5 the only way to handle failures so that
test execution is not terminated immediately was using BuiltIn_ keywords
:name:`Run Keyword And Ignore Error` and :name:`Run Keyword
And Expect Error`. Using these keywords for this purpose often added
extra complexity to test cases, and in Robot Framework 2.5 the
following features were added to make continuing after failures
easier.

Special failures from keywords
''''''''''''''''''''''''''''''

`Library keywords`_ report failures using exceptions, and it is
possible to use special exceptions to tell the core framework that
execution can continue regardless the failure. How these exceptions
can be created is explained in the `test library API chapter`__.

When a test ends and there has been one or more continuable failure,
the test will be marked failed. If there are more than one failure,
all of them will be enumerated in the final error message::

  Several failures occurred:

  1) First error message.

  2) Second error message ...

Test execution ends also if a normal failure occurs after continuable
failures. Also in that case all the failures will be listed in the
final error message.

The return value from failed keywords, possibly assigned to a
variable, is always the Python :code:`None`.

__ `Continuing test execution despite of failures`_

:name:`Run Keyword And Continue On Failure` keyword
'''''''''''''''''''''''''''''''''''''''''''''''''''

BuiltIn_ keyword :name:`Run Keyword And Continue On Failure` allows
converting any failure into a continuable failure. These failures are
handled by the framework exactly the same way as continuable failures
originating from library keywords.

Execution continues on teardowns automatically
''''''''''''''''''''''''''''''''''''''''''''''

To make it sure that all the cleanup activities are taken care of, the
continue on failure mode is automatically on in `test and suite
teardowns`__. In practice this means that in teardowns all the
keywords in all levels are always executed.

__ `Setups and teardowns`_

All top-level keywords are executed when tests have templates
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

When using `test templates`_, all the data rows are always executed to
make it sure that all the different combinations are tested. In this
usage continuing is limited to the top-level keywords, and inside them
the execution ends normally if there are non-continuable failures.

Stopping test execution gracefully
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sometimes there is a need to stop the test execution before all the tests
have finished, but so that logs and reports are created. Different ways how
to accomplish this are explained below. In all these cases the remaining
test cases are marked failed.

.. Note:: Most of these features are new in Robot Framework 2.5.

Pressing :code:`Ctrl-C`
'''''''''''''''''''''''

The execution is stopped when :code:`Ctrl-C` is pressed in the console
where the tests are running. When running the tests on Python, the
execution is stopped immediately, but with Jython it ends only after
the currently executing keyword ends.

If :code:`Ctrl-C` is pressed again, the execution ends immediately and
reports and logs are not created.

Using signals
'''''''''''''

On Unix-like machines it is possible to terminate test execution
using signals :code:`INT` and :code:`TERM`. These signals can be sent
from the command line using :prog:`kill` command, and sending signals can
also be easily automated.

Signals have the same limitation on Jython as pressing :code:`Ctrl-C`.
Similarly also the second signal stops the execution forcefully.

Using keywords
''''''''''''''

The execution can be stopped also by the executed keywords. There is a
separate :name:`Fatal Error` BuiltIn_ keyword for this purpose, and
custom keywords can use `fatal exceptions`__ when they fail.

__ `Stopping test execution`_

Stopping when first test case fails
'''''''''''''''''''''''''''''''''''

If option :opt:`--exitonfailure` is used, test execution stops
immediately if any `critical test`_ fails. Also the remaining tests
are marked as failed.

.. note:: Prior to Robot Framework 2.8, this behaviour was achieved by
          using :opt:`--runmode exitonfailure`. Option :opt:`--runmode`
          was deprecated in 2.8 and will be removed in the future.

Handling teardowns
''''''''''''''''''

By default teardowns of the tests and suites that have been started are
executed even if the test execution is stopped using one of the methods
above. This allows clean-up activities to be run regardless how execution
ends.

It is also possible to skip teardowns when execution is stopped by using
:opt:`--skipteardownonexit` option. This can be useful if, for example,
clean-up tasks take a lot of time.

.. note:: Prior to Robot Framework 2.8, this behaviour was achieved by
          using :opt:`--runmode skipteardownonexit`. Option :opt:`--runmode`
          was deprecated in 2.8 and will be removed in the future.
