H2O.InspectsOutput = (_, _tables) ->
  createTableView = (table) ->
    inspect = -> 
      _.insertAndExecuteCell 'cs', "inspect #{stringify table.label}, #{table.metadata.origin}"

    grid = ->
      _.insertAndExecuteCell 'cs', """
      plot (g) -> g(
        g.table()
        g.from inspect #{stringify table.label}, #{table.metadata.origin}
      )
      """

    plot = ->
      _.insertAndExecuteCell 'cs', table.metadata.plot

    label: table.label
    description: table.metadata.description
    #variables: table.variables #XXX unused?
    inspect: inspect
    grid: grid
    canPlot: if table.metadata.plot then yes else no
    plot: plot

  hasTables: _tables.length > 0
  tables: map _tables, createTableView
  template: 'flow-inspects-output'

