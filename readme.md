# Node vs Ruby I/O

Comparison of I/O performance for Node and Ruby.

Operations:
* read raw image from disk
* resize it in small, medium and large size
* write thumbnails to disk

## Results
### Large image
![](/large-benchmark.png)

### Small image
![](/small-benchmark.png)

## Running benchmarks

You will need [libvips](https://github.com/jcupitt/libvips) installed.

For MacOS do

```
brew install vips
```

After that run

```
rake
```

# License

MIT
