// Use `rake react:update` to build this bundle & copy files into the gem.
var webpack = require("webpack");

var searchkitRailsEnv = process.env.NODE_ENV == "production" ? "production" : "development";

var plugins = [];

if (searchkitRailsEnv == "production") {
  var definePlugin = new webpack.DefinePlugin({'process.env.NODE_ENV': '"production"'});
  var minifyPlugin = new webpack.optimize.UglifyJsPlugin({
    compress: {
        warnings: false
    }
  });
  plugins.push(definePlugin);
  plugins.push(minifyPlugin);
}


module.exports = {
  context: __dirname,
  entry: {
    "searchkit": "./searchkit.js",
  },
  output: {
      path: __dirname + "/build/" + searchkitRailsEnv,
      filename: "[name].js",
  },
  plugins: plugins,
};