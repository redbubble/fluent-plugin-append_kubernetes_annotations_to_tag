# fluent-plugin-append_kubernetes_annotations_to_tag

## A Fluent plugin to add kubernetes container annotations to the log tag

## Prerequisites

This plugin is intended for use with the [kuberenetes_metadata_filter](https://github.com/fabric8io/fluent-plugin-kubernetes_metadata_filter) plugin. You will need to filter with `kubernetes_metadata_filter` so that your log records have the `kubernetes` attribute loaded with the required data.

## Usage

In your Gemfile:

```ruby
gem 'fluent-plugin-append-kubernetes-annotations-to-tag'
```

In your Fluent config:

```
<filter **>
  @type kubernetes_metadata_filter # See 'Prerequisites' above

  ...

</filter>

<filter **>
  @type append_kubernetes_annotations_to_tag

  annotations ['log_destination']
</filter>
```


## Contributing

If you would like to contribute a fix or feature, here's what you should do:

1. Raise an issue so we can discuss your change
1. Fork this repo
1. Make your changes
1. Submit a pull request

## Maintainers

delivery-engineers@redbubble.com


    fluent-plugin-append_kubernetes_annotations_to_tag

    Copyright (C) Redbubble

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
