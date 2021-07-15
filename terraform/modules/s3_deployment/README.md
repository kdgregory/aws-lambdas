Manages a Lambda deployment bundle in S3.

One of the challenges with using S3 as a deployment source is getting the bundle
there in the first place. You can call the AWS CLI from your build tool, but you
need logic to decide whether or not you _should_ upload the bundle: while you
might always want to overwrite a development bundle, overwriting a prod bundle
indicates a problem in your build.

This module uses the `aws_s3_bucket_objects` data source to determine whether
the bundle already exists, and allows you to control whether it is overwritten
if it does.


## Configuration

* `s3_bucket`

  The bucket where the deployment bundle is/should be stored. Note that this
  must reside in the same region as your Lambda function.

  Default: none; you must specify this.

* `s3_key`

  The Amazon S3 key of the deployment package.

  Default: none; you must specify this.

* `source`

  The name of a local file containing the deployment bundle. If you omit this,
  and the bundle does not already exist on S3, apply will fail.

  Default: null

* `overwrite`

  If `true`, the bundle on S3 will be overwritten, unless it is identical to the
  source file. This is useful in a development environment, but should not be used
  in production. You must provide `source`.

  Default: false.


## Outputs

The module provides the provided`s3_bucket` and `s3_key` as outputs.


## Example

In all of the examples below, update `COMMIT` to an appropriate hash. Do not use `trunk`
unless you're OK with deployment configs that may change outside of your control.

```
```


## Implementation Notes
