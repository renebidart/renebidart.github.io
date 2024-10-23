# renebidart.github.io

## Possible Improvements
Consider making a different blog page, with an explaination for each, like why i did sequential statified sampling, conflict with prof, nips was my first time now renamed, the open research was based on reading you and your research / david patterson and feeling uncertain after going into pure research, and the meditation was maybe because of being stuck in waterloo and abandoning healthcare, wanting to do ai but not in a concrete way.


To collapse a series of related posts (e.g., "Open Research") into a single item on the main page:

1. Create a new content file for the series: `content/series-name/_index.md`
2. Add a custom layout for the series: `layouts/series-name/list.html`
3. Modify existing posts in the series to use `type: series-name` in their front matter
4. Update `layouts/index.html` to display the series as a single item

This approach keeps the main page clean while providing easy access to the entire series.

For detailed implementation, refer to the commit history or contact the repository owner.
