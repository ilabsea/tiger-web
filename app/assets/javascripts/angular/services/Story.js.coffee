app.factory "Story", ["$resource", ($resource) ->
  $resource("/api/stories/:id", {id: "@id", format: 'json'},
              {
                create: {method: "POST"},
                index: {method: "GET", isArray: true},
                show:    { method: 'GET', isArray: false },
                update: {method: "PUT"},
                destroy: { method: 'DELETE' }
              }
            )
]
