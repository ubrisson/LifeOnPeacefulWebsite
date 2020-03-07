const { environment } = require('@rails/webpacker');

module.exports = environment;

// Enable the default config
environment.splitChunks();