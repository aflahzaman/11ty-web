---
eleventyNavigation:
  parent: Configure Templates with Data
  key: Permalinks
  pinned: true
  excerpt: Remap a template to a new output location (or prevent writing a file)
---

# Permalinks

{% tableofcontents %}

You can customize the default location of templates to the output directory (or disable writing a file to disk entirely) using Eleventy’s permalinks feature.

<div id="default-input/output-examples"></div>

Here’s a few examples of how it works by default (assuming your output directory is the default, `_site`):

<table>
    <tbody>
        <tr>
            <th>Input</th>
            <td><code>index.njk</code></td>
        </tr>
        <tr>
            <th>Output</th>
            <td><code>_site/index.html</code></td>
        </tr>
        <tr>
            <th>Href</th>
            <td><code>/</code></td>
        </tr>
    </tbody>
</table>

<table>
    <tbody>
        <tr>
            <th>Input</th>
            <td><code>template.njk</code></td>
        </tr>
        <tr>
            <th>Output</th>
            <td><code>_site/template/index.html</code></td>
        </tr>
        <tr>
            <th>Href</th>
            <td><code>/template/</code></td>
        </tr>
    </tbody>
</table>

<table>
    <tbody>
        <tr>
            <th>Input</th>
            <td><code>subdir/template.njk</code></td>
        </tr>
        <tr>
            <th>Output</th>
            <td><code>_site/subdir/template/index.html</code></td>
        </tr>
        <tr>
            <th>Href</th>
            <td><code>/subdir/template/</code></td>
        </tr>
    </tbody>
</table>

<table>
    <tbody>
        <tr>
            <th>Input</th>
            <td><code>subdir/template/template.njk</code> or <code>subdir/template/index.njk</code></td>
        </tr>
        <tr>
            <th>Output</th>
            <td><code>_site/subdir/template/index.html</code></td>
        </tr>
        <tr>
            <th>Href</th>
            <td><code>/subdir/template/</code></td>
        </tr>
    </tbody>
</table>

## Cool URIs don’t change

Eleventy automatically helps you make sure that [Cool URIs don’t change](https://www.w3.org/Provider/Style/URI).

> What to leave out…
> File name extension. This is a very common one. "cgi", even ".html" is something which will change. You may not be using HTML for that page in 20 years time, but you might want today's links to it to still be valid. The canonical way of making links to the W3C site doesn't use the extension.

## Changing the output location

<div id="remapping-output-(permalink)"></div>

To remap your template’s output to a different path than the default, use the `permalink` key in the template’s front matter. If a subdirectory does not exist, it will be created.

{% codetitle "YAML Front Matter", "Syntax" %}

```markdown
---
permalink: "this-is-a-new-path/subdirectory/testing/"
---
```

The above is functionally equivalent to:

{% codetitle "YAML Front Matter", "Syntax" %}

```markdown
---
permalink: "this-is-a-new-path/subdirectory/testing/index.html"
---
```

Both of the above examples write to `_site/this-is-a-new-path/subdirectory/testing/index.html`.

Fear not: if multiple input files _attempt to write to the same output location_, Eleventy will throw an error for you!

{% callout "warn", "md" %}While `index.html` is optional, it is a [**Common Pitfall**](/docs/pitfalls/) to leave off the trailing slash! If you forget it, the browser may attempt to download the file instead of displaying it (unless you’ve done some extra work to set up your `Content-Type` headers correctly).{% endcallout %}

### Skip writing to the file system

<div id="permalink-false"></div>

If you set the `permalink` value to be `false`, this will disable writing the file to disk in your output folder. The file will still be processed normally (and present in collections, with its [`url` and `outputPath` properties](/docs/data-eleventy-supplied/) set to `false`) but will not be available in your output directory as a standalone template.

{% codetitle "YAML Front Matter", "Syntax" %}

```markdown
---
permalink: false
---
```

### Use template syntax in Permalink

You may use data variables here (and template syntax, too). These will be parsed with the current template’s rendering engine. It’s recommended to use the provided [`slugify` filter](/docs/filters/slugify/) to create URL-safe strings from data.

<div id="use-filters"></div>

For example:

{% codetitle "YAML Front Matter using Liquid, Nunjucks", "Syntax" %}

{% raw %}

```markdown
---
title: This is a New Path
permalink: "subdir/{{ title | slugify }}/index.html"
---
```

{% endraw %}

- Pagination variables also work here! [Read more about Pagination](/docs/pagination/)

Writes to `_site/subdir/this-is-a-new-path/index.html`.

{% callout "info", "md" %}Using the data cascade you have the power to change the default behavior for permalinks for all content in your project. Learn more about the special `page` variables useful for permalinks to see examples of this behavior: [`page.fileSlug`](/docs/data-eleventy-supplied/#fileslug) and [`page.filePathStem`](/docs/data-eleventy-supplied/#filepathstem).{% endcallout %}

<details>
  <summary>Expand to see another example using Liquid’s <code>date</code> filter.</summary>

{% codetitle "YAML Front Matter using Liquid", "Syntax" %}

{% raw %}

```markdown
---
date: "2016-01-01T06:00-06:00"
permalink: "/{{ page.date | date: '%Y/%m/%d' }}/index.html"
---
```

{% endraw %}

Writes to `_site/2016/01/01/index.html`. There are a variety of ways that the page.date variable can be set (using `date` in your front matter is just one of them). Read more about [Content dates](/docs/dates/).

</details>

#### Put quotes around template syntax in YAML

<div id="warning-about-yaml-objects"></div>

{% callout "warn", "md" %}**YAML Pitfall:** If your permalink uses template syntax, make sure that you use quotes! Without quotes YAML may try to parse this as an object if the first character is a `{`, for example `permalink: {% raw %}{{ page.filePathStem }}{% endraw %}.html`. This is a [**common pitfall**](/docs/pitfalls/).{% endcallout %}

{% codetitle "YAML", "Syntax" %}

{% raw %}

```yaml
permalink: "{{ page.filePathStem }}.html"
```

{% endraw %}

The error message might look like `can not read a block mapping entry; a multiline key may not be an implicit key`.

### Custom File Formats

You can change the file extension in the permalink to output to any file type. For example, to generate a JSON search index to be used by popular search libraries:

{% codetitle "EJS", "Syntax" %}

```markdown
---
permalink: "index.json"
---

<%- JSON.stringify(collections.all) -%>
```

## Trailing Slashes

Eleventy projects use trailing slashes by default, as they have shown to be the most reliable approach for URL design and [hosting provider compatibility](https://www.zachleat.com/web/trailing-slash/#results-table). That’s why we write to `/resource/index.html` and use `/resource/`-style URLs.

We do offer the option to instead write `/resource.html` files and use `/resource`-style URLs **(but it is not recommended)**.

### Permalinks without File Extensions

{% callout "warn", "md-block" -%}
While `index.html` is optional on `permalink: /resource/index.html`, it is a [**Common Pitfall**](/docs/pitfalls/) to leave off the trailing slash.
{% endcallout %}

If you leave off the file name **and** forget the trailing slash on your permalink, this will write to a file without a file extension. Your web browser may attempt to download the file instead of displaying it (unless you’ve done some extra work to set up your `Content-Type` headers correctly).

This may also cause local development issues if you later attempt to write to a subdirectory of the same name (anything inside `/resource/`).

- `permalink: /resource/` ✅ Fine
- `permalink: /resource/index.html` ✅ The same as above
- `permalink: /resource` ❌ Not fine, throws an error in 3.0

{% addedin "3.0.0-beta.2" %}Eleventy will throw an error if you attempt to write to a file without a file extension. This is not always an error (think `_redirects` on Netlify), so you can opt out of this feature by setting `eleventyAllowMissingExtension: true` somewhere in your data cascade (front matter, directory data file, etc) or disable the error messaging globally.

```yaml
---
eleventyAllowMissingExtension: true
---
```

{% set codeContent %}
export default function(eleventyConfig) {
	// Disable this error for the project.
	eleventyConfig.configureErrorReporting({ allowMissingExtensions: true })
};
{% endset %}
{% include "snippets/configDefinition.njk" %}

<div id="change-permalinks-globally-for-a-project"></div>

### Remove trailing slashes

The following configuration (using [global data via the configuration API](/docs/data-global-custom.md) but you could set this using a [Global Data file](/docs/data-global.md) too) unlocks `/resource`-style URLs on your Eleventy project and works on GitHub Pages, Netlify, Cloudflare Pages, Render, and Azure Static Web Apps. This approach **does _not_ work on Vercel** (due to a [Vercel hosting limitation](https://www.zachleat.com/web/trailing-slash/#results-table)).

{% set codeContent %}
export default function(eleventyConfig) {
	// Set global permalinks to resource.html style
	eleventyConfig.addGlobalData("permalink", () => {
		return (data) =>
			`${data.page.filePathStem}.${data.page.outputFileExtension}`;
	});

	// Remove .html from `page.url`
	eleventyConfig.addUrlTransform((page) => {
		if (page.url.endsWith(".html")) {
			return page.url.slice(0, -1 * ".html".length);
		}
	});
};
{% endset %}
{% include "snippets/configDefinition.njk" %}

#### Remove trailing slashes on Vercel

The following works for `/resource`-style URLs on Vercel but additionally requires [`"trailingSlash": false` in your `vercel.json` file](https://vercel.com/docs/projects/project-configuration#trailingslash).

{% set codeContent %}
export default function(eleventyConfig) {
	eleventyConfig.addUrlTransform((page) => {
		// remove trailing slash from `page.url`
		if (page.url !== "/" && page.url.endsWith("/")) {
			return page.url.slice(0, -1);
		}
	});
};
{% endset %}
{% include "snippets/configDefinition.njk" %}


## Advanced Usage

### Change permalinks for one directory

Let's say you have a directory of content templates like `recipes/cookies.md` and `recipes/soup.md` and 50 more. Each of these content templates has a title in their frontmatter. While you could manually set a permalink in the frontmatter of each recipe you can also dynamically generate the permalink inside a [Directory Data File](/docs/data-template-dir/) like `recipes.11tydata.js`.

Because of the order of the [data cascade](/docs/data-cascade/) the title of a content template is not immediately available in the directory data file. However, `permalink` is a special case of implied [Computed Data](./data-computed.md) and will have this data available. Inside of your directory data file `recipes.11tydata.js` you could write this:

<div class="codetitle codetitle-right-md">recipes.11tydata.js</div>
{% set codeContent %}
export default {
	permalink: function ({ title }) {
		return `/recipes/${this.slugify(title)}`;
	},
};
{% endset %}
{% include "snippets/esmCjsTabs.njk" %}

The title will be [slugified](/docs/filters/slugify/) to be URL-friendly.

### Mapping one URL to Multiple Files for Internationalization {% addedin "2.0.0-canary.13" %}

_Decouple a page’s primary URL from its permalink._

As an example, say you have two content files: `about.en.html` and `about.es.html`. You’ve already set up the [`addGlobalData` feature to remap their respective output](/docs/data-eleventy-supplied/#changing-your-project-default-permalinks) to `_site/about.en.html` and `_site/about.es.html`.

Use [server-side redirects](https://docs.netlify.com/routing/redirects/redirect-options/#redirect-by-country-or-language) to control which of these files is shown.

- [Netlify Redirects](https://docs.netlify.com/routing/redirects/redirect-options/#redirect-by-country-or-language)
- [Apache Content Negotiation](https://fantasai.inkedblade.net/web-design/l10n) related to [Issue #761](https://github.com/11ty/eleventy/issues/761)

These will work as expected out of the box, except for the [`page.url`](/docs/data-eleventy-supplied/#page-variable) variable and the URL reported in [collection objects](/docs/collections/#collection-item-data-structure) (et al).

Say we want two or more files on the file system (e.g. `about.en.html` and `about.es.html`) to map to a single page URL (`/about/`—not ~~`/about.en.html`~~ or ~~`/about.es.html`~~). This is now possible using a new URL Transforms feature. URL transforms let you modify the `page.url` for a content document based.

This example matches any `.xx.html` URL:

{% set codeContent %}
export default function (eleventyConfig) {
	eleventyConfig.addUrlTransform(({ url }) => {
		// `url` is guaranteed to be a string here even if you’re using `permalink: false`
		if (url.match(/\.[a-z]{2}\.html$/i)) {
			return url.slice(0, -1 * ".en.html".length) + "/";
		}

		// Returning undefined skips the url transform.
	});
};
{% endset %}
{% include "snippets/configDefinition.njk" %}

### Disable templating in permalinks {% addedin "0.7.0" %}

Some template syntaxes are nicer than others and you may want to opt-out of the templating engine here. Use the `dynamicPermalink` option in your front matter to disable this on a per-template basis.

{% callout "warn" %}This is a <a href="/docs/pitfalls/"><strong>common pitfall</strong></a> for users of the Pug templating engine.{% endcallout %}

{% codetitle "YAML Front Matter", "Syntax" %}

```markdown
---
permalink: "/this-will-be-a-string-without-templating/"
dynamicPermalink: false
---
```

#### Globally disable templating in permalinks {% addedin "0.3.4" %}

Eleventy includes a global configuration option to disable dynamic templating altogether. This will save a few template renders and is probably marginally faster, too.

{% set codeContent %}
export default function (eleventyConfig) {
	// Enabled by default
	eleventyConfig.setDynamicPermalinks(false);
};
{% endset %}
{% include "snippets/configDefinition.njk" %}


### Ignore the output directory {% addedin "0.1.4" %}

To remap your template’s output to a directory independent of the output directory (`--output`), use `permalinkBypassOutputDir: true` in your front matter.

{% codetitle "YAML Front Matter", "Syntax" %}

```markdown
---
permalink: "_includes/index.html"
permalinkBypassOutputDir: true
---
```

Writes to `_includes/index.html` even though the output directory is `_site`. This is useful for writing child templates to the `_includes` directory for re-use in your other templates.