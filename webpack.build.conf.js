const { merge } = require('webpack-merge');
const baseWebpackConfig = require('./webpack.base.conf');
const webpack = require('webpack');

const buildWebpackConfig = merge(baseWebpackConfig, {
  //!!!
  //CAUTION Production config
  //!!!
  mode: 'production',
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        REACT_APP_MAPBOX_TOKEN: JSON.stringify(
          process.env.REACT_APP_MAPBOX_TOKEN
        ),
      },
    }),
  ],
});

module.exports = new Promise((resolve, reject) => {
  resolve(buildWebpackConfig);
});
