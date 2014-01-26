Package.describe({
  summary: "A plugin package"
});

Package.on_use(function(api) {
  api.use(["coffeescript"])

  api.add_files([
    "plugin.coffee"
  ], ["client"]);
});

