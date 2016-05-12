# searchkit-rails
Makes it easy to add searchkit.co to your rails application.

[![Build Status](https://travis-ci.org/drewry/searchkit-rails.svg?branch=master)](https://travis-ci.org/drewry/searchkit-rails)

## Dependencies
You will need to install [react-rails](https://github.com/reactjs/react-rails) and follow those installation instructions first before beginning with `searchkit-rails`.

```
gem 'react-rails'
```

## Installation
Add `searchkit-rails` to your gemfile:

```
gem 'searchkit-rails'
```

And install:

```
bundle install
```

Finally, run the searchkit installation script:

```
rails g searchkit:install
```

This will:

* place the following in your application.js before `react-rails`:

```
//= require searchkit
//= require react
//= require react_ujs
//= require components
```

* place the following in your application.css:

```
*= require searchkit
```

## Usage
You can use `searchkit-rails` to easily add the searchkit components to your project.

### Demo
Start with a react component generator:

```
rails generate react:component App
```

Now in your `components/app.js.jsx` add the following:

```jsx
const host = "http://demo.searchkit.co/api/movies"
const sk = new Searchkit.SearchkitManager(host, {})

var App = React.createClass({
  render: function() {
    const SearchkitProvider      = Searchkit.SearchkitProvider;
    const Searchbox              = Searchkit.SearchBox;
    const Hits                   = Searchkit.Hits;
    const NoHits                 = Searchkit.NoHits;
    const HitsStats              = Searchkit.HitsStats;
    const Layout                 = Searchkit.Layout;
    const LayoutBody             = Searchkit.LayoutBody;
    const LayoutResults          = Searchkit.LayoutResults;
    const SearchBox              = Searchkit.SearchBox;
    const TopBar                 = Searchkit.TopBar;
    const SideBar                = Searchkit.SideBar;
    const ActionBar              = Searchkit.ActionBar;
    const ActionBarRow           = Searchkit.ActionBarRow;
    const HierarchicalMenuFilter = Searchkit.HierarchicalMenuFilter;
    const RefinementListFilter   = Searchkit.RefinementListFilter;
    const SelectedFilters        = Searchkit.SelectedFilters;
    const ResetFilters           = Searchkit.ResetFilters;
    const MovieHitsGridItem      = Searchkit.MovieHitsGridItem;

    return (<div>
      <SearchkitProvider searchkit={sk}>
        <Layout>
          <TopBar>
            <SearchBox autofocus={true} searchOnChange={true} prefixQueryFields={["actors^1","type^2","languages","title^10"]}/>
          </TopBar>
          <LayoutBody>
            <SideBar>
              <HierarchicalMenuFilter fields={["type.raw", "genres.raw"]} title="Categories" id="categories"/>
              <RefinementListFilter id="actors" title="Actors" field="actors.raw" operator="AND" size={10}/>
            </SideBar>
            <LayoutResults>
              <ActionBar>
                <ActionBarRow>
                  <HitsStats/>
                </ActionBarRow>
                <ActionBarRow>
                  <SelectedFilters/>
                  <ResetFilters/>
                </ActionBarRow>
              </ActionBar>
              <Hits mod="sk-hits-grid" hitsPerPage={10} itemComponent={MovieHitsGridItem} sourceFilter={["title", "poster", "imdbId"]}/>
              <NoHits/>
            </LayoutResults>
          </LayoutBody>
        </Layout>
      </SearchkitProvider>
    </div>);
  }
});
```

Now in your templates you can run:

```
<%= react_component('App') %>
```
