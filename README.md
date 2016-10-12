<h3>Setup instruction</h3>
<ul>
    <li>$ bundle install</li>
    <li>$ foreman start</li>
</ul>

<h3>Progress</h3>
<ul>
    <li>$ racksh</li>
    <li>> Message.primary_key</li>
    <li>output: => "link"</li>
    <li>> Message.count</li>
    <li>output: => 0</li>
    <li>> Message.create(link: "1:aFlKipUi", body: "aFlKipUidsKJdsf-sJNJsdfsdf")</li>
    <li>> Message.count</li>
    <li>output: => 1</li>
</ul>