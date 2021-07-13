Creates an SQS queue and optional dead-letter queue. In addition, creates managed
producer and consumer policies, and exposes IAM statements that can be composed
into an inline (or other) policy.



## Configuration

There are lots of variables, and many have defaults. While most are obvious, and tie
directly to the [aws_lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function)
arguments, some have peculiarities described below.

A note on default values: some variables have meaningful defaults, some have "null"
as the default, and some have "none". Those with null will be ignored if you do not
provide a default; for example, `tags`. Those with none must be specified in your
configuration.

* `name`

  The name of the primary queue. Also used as base name of the dead-letter queue,
  if used.

  Default: none; you must specify this.

* `visibility_timeout_seconds`

  The number of seconds that a message will be invisible to other consumers once
  retrieved.

  Default: 30 (SQS default)

* `retention_days`

  The number of days that the primary queue retains unprocessed messages. This module
  uses days for this value, rather than seconds, because I believe that it improves
  maintainability. You can use a decimal number (eg, 0.5 for half a day), although
  small numbers won't be exact (eg, if you want an hour, 0.0417 is 3602 seconds).

  Default: 4 (SQS default)

* `dlq_retention_days`

  The number of days that the dead letter queue retains unprocessed messages. As with
  `message_retention_days`, this is specified in days.

  Default: value of `dlq_retention_days`

* `retry_count`

  The maximum number of times that a message should be delivered before moving
  to the dead-letter queue. Specifying this parameter is the way to create a
  dead-letter queue.

  Default: null (messages will be delivered indefinitely (until they time out
  due to the queue's retention limit).


## Outputs

This module provides the following outputs, for use by consuming modules. All outputs
refer to the created resource, so you can access all attributes of the resource (not
just its name or ARN).

* `primary`

  The primary queue

* `dead_letter_queue`

  The dead-letter queue, if it exists.

* `producer_policy_arn`

* `consumer_policy_arn`

* `producer_statement`

* `consumer_statement`



## Examples

In all of the examples below, update `COMMIT` to an appropriate hash. Do not use `trunk`
unless you're OK with deployment configs that may change outside of your control.


### A basic queue


```
```


### Using a dead-letter queue and redrive policy


```
```


## Implementation Notes

### Producer and Consumer Policies

