const path    = require("path")
const webpack = require("webpack")
const mode = process.env.NODE_ENV === 'development' ? 'development' : 'production';

module.exports = {
  mode: mode,
  entry: {
    application: "./app/javascript/application.js"
  },
  optimization: {
    moduleIds: 'deterministic',
  },
  output: {
    filename: "[name].js",
    sourceMapFilename: "[file].map",
    path: path.resolve(__dirname, '..', '..', 'app/assets/builds')
  },
  devServer: {
    static: {
      directory: path.join(__dirname, 'public'),
    },
    compress: true,
    port: 9000,
  },
  optimization: {
    runtimeChunk: 'single',
  },
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    })
  ]
}
