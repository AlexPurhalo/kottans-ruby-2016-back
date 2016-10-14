<h3>Setup instruction</h3>
<ul>
    <li>$ bundle install</li>
    <li>$ foreman start</li>
</ul>

<h3>Progress</h3>
<ul>
    <li>visit http://localhost:5000/swagger-ui/</li>
    <li>checkout List Operations</li>
    <li>go to options list then to POST request for /messages path</li>
    <li>passing something to body and small time to exist_hours as 0.005 submit data</li>
    <li>go http://localhost:5000/sidekiq/</li>
    <li>ensure that you have one busy process</li>
    <li>after small time proccess should be killed with record in db</li>
</ul>