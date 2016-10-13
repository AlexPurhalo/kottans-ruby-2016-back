<h3>Setup instruction</h3>
<ul>
    <li>$ bundle install</li>
    <li>$ foreman start</li>
</ul>

<h3>Progress</h3>
<ul>
    <li>visit http://localhost:5000/swagger-ui/</li>
    <li>checkout List Operations</li>
    <li>create message with POST request by /messages passing body and visits_limit</li>
    <li>check output with views_count and visits_limit</li>
    <li>go to created message passing created link to GET request by messages/id address</li>
    <li>check that views_count was incremented by one</li>
    <li>visit link acoding passed visits_limit times</li>
    <li>ensure that after you've reached limit message was destroyed</li>
    <li>
        <p>Here how it looks</p>
        <img src="https://raw.githubusercontent.com/AlexPurhalo/kottans-ruby-2016-back/master/guide/visits-limit-implementation.png"/>
        <img src="https://raw.githubusercontent.com/AlexPurhalo/kottans-ruby-2016-back/master/guide/visits-limit-view.png"/>
    </li>
</ul>