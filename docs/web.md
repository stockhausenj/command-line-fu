# Web
## Performance
### Real User Monitoring (RUM)
The three measurements Cloudflare used during a edge network performance test. <a href="https://blog.cloudflare.com/benchmarking-edge-network-performance/">Source</a>.

TCP connection time
```javascript
// connectEnd - connectStart
```
TTFB (time to first byte)
```javascript
// responseStart - connectEnd
```
TTLB (time to last byte)
```javascript
// requestStart - connectEnd
```
To create a report via Console:
```javascript
var htmls = performance.getEntriesByType("navigation");
for (var i=0; i < htmls.length; i++) {
    console.log("Name: " + (htmls[i].name));
    console.log("TCP connection time: " + (htmls[i].connectEnd - htmls[i].connectStart) + " ms");
    console.log("TTFB: " + (htmls[i].responseStart - htmls[i].connectEnd) + " ms");
    console.log("TTLB: " + (htmls[i].requestStart - htmls[i].connectEnd) + " ms");
}
var resources = performance.getEntriesByType("resource");
for (var i=0; i < resources.length; i++) {
    console.log("Name: " + (resources[i].name));
    console.log("TCP connection time: " + (resources[i].connectEnd - resources[i].connectStart) + " ms");
    console.log("TTFB: " + (resources[i].responseStart - resources[i].connectEnd) + " ms");
    console.log("TTLB: " + (resources[i].requestStart - resources[i].connectEnd) + " ms");
}
```

Other useful loading time metrics available <a href="https://developer.mozilla.org/en-US/docs/Web/API/Resource_Timing_API/Using_the_Resource_Timing_API">here</a>.