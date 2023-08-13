use std

export def-env url [url] {
    if ('http_cache' in $env) {
    } else {
        $env.http_cache = []
    }
    let $found = $env.http_cache | where url == $url
    if ($found | is-empty) {
        let value = http get $url
        let new_cache = $env.http_cache | append {url: $url value: $value}
        # std log info ($new_cache | get url | to text)
        $env.http_cache = $new_cache
        $value
    } else {
        $found | get 0.value
    }
}

