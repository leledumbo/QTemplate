<!doctype html>
<html>
  <head>
    <title>{+title+}</title>
  </head>
  <body>
    <h1>{+title+}<h1>
    <p>In table form:</p>
    {+itemlist
      [-header=<table>-]
      [-row=<tr><td>~no</td><td>~value</td></tr>-]
      [-footer=</table>-]
    +}
    <p>In list form:</p>
    {+itemlist
      [-header=<ul>-]
      [-row=<li>~value</li>-]
      [-footer=</ul>-]
    +}
  </body>
</html>
