<?php
$u = $_SERVER['HTTP_USER_AGENT'];

$isIE7  = (bool)preg_match('/msie 7./i', $u );
$isIE8  = (bool)preg_match('/msie 8./i', $u );


if ($isIE7 || $isIE8) {
  header('Location: ie.php');
    exit;
}

$vcorrente=13;
$ok=false;
if (isset($_GET['v'])) {$v=$_GET['v'];$ok=true;} else {$v=13;}
?>

<!DOCTYPE html>
<!--[if IE 6 ]><html lang="en-us" class="ie6"> <![endif]-->
<!--[if IE 7 ]><html lang="en-us" class="ie7"> <![endif]-->
<!--[if IE 8 ]><html lang="en-us" class="ie8"> <![endif]-->
<!--[if (gt IE 7)|!(IE)]><!-->
<html class=" js csstransitions desktop portrait" lang="en-US"><!--<![endif]--><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <!-- ==============================================
         Title and basic Meta Tags
         =============================================== -->    
      <meta charset="utf-8">
      <title>myTRG - myToRTuGA Tray Bar</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <meta name="description" content="Finalmente è arrivata... myTRG - myToRTuGA Tray Bar">
      <meta name="keywords" content="">
      <!-- ==============================================
         Mobile Metas
         =============================================== --> 	
      <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
      <!-- ==============================================
         Google Fonts
         =============================================== -->     
      <link href="template/css.css" rel="stylesheet" type="text/css">
      <!-- ==============================================
         CSS
         =============================================== -->                
      <link rel="stylesheet" type="text/css" href="template/bootstrap.css">
      <link rel="stylesheet" type="text/css" href="template/font-awesome.css">
      <link rel="stylesheet" type="text/css" href="template/font-awesome.min.css">
      <link rel="stylesheet" type="text/css" href="template/style.css">
      <link rel="shortcut icon" href="favicon.ico" />
   </head>
   <body class="">
      <!-- Overlay -->     
      <div class="bg-overlay"></div>
      <!-- End Overlay -->    
      
      <!-- Header --> 
      <header>
         <div class="intro">
            <!-- Site Logo -->
            <div class="logo"></div>
            <!-- End Site Logo -->
            
            <?php
              if ($v<$vcorrente)
            {
                
            ?>
           <!-- Rotator Title --> 
            <div id="rotate">
               <h1 style="display: none;" class="rotate"><span>!! Aggiorna la tua versione !!</span></h1>
               <h1 style="display: none;" class="rotate"><span>E' disponibile una nuova versione.</span></h1>
            </div>
            <?php
            }
            else
            {
                 if ($ok==true){
                   ?>
            <!-- Rotator Title --> 
                <div id="rotate">
                   <h1 style="display: none;" class="rotate">La tua versione e' aggiornata<span></span></h1>

                </div>
           <?php
                }
                else{
             ?>
            
                <!-- Rotator Title --> 
                <div id="rotate">
                   <h1 style="display: none;" class="rotate">my<span>TRG</span><br><span>ToRTuGA   </span> Tray Bar <span></span></h1>
                   <h1 style="display: block;" class="rotate">I miglior <span> Bookmarks </span> direttamente <span> </span><br> dal tuo desktop</span>. <span>Autoaggiornati</h1>
                </div>
                <?php
                }
            }
            ?>
            <!-- End Rotator Title -->

            <p>I miglior siti italiani e internazionali</p>
            <p><span></span><img src="template/3.jpg"><span></span></p>
            <p>di Torrent,Streaming,Download...</p>
            <br>
            <img src='template/1.jpg'>    <img src='template/2.jpg'>
            <br>
            
          
                   
         </div>
         <!-- Nav -->
         <nav>
            <ul class="navigation">
               <li class="link left middle side move"><a href="#about" title="About">Info e Changelog</a></li>
               <li class="link right middle side move"><a href="#contact" title="Contact">Suggerisci sito</a></li>
               <li class="link center bottom move"><a class="btn" href="#subscribe" title="Download">Download myTRG v1.3</a></li>
            </ul>
         </nav>
         <!-- End Nav -->
      </header>
      <!-- End Header -->
      
      <!-- About Section -->
      <section id="about" data-direction="from-left">
         <div class="container">
            <a href="#" class="close"></a>
            
            
            <h1>
               <span>INFO</span>
            </h1>
            <!-- ./End Section Title -->
            <div class="row text-center">
               <div class="col-md-8 col-md-offset-2">
                  <h4>Versione attuale: v1.3</h4>
                      <br>
                      Questo semplice tool vi permette di rimanere aggiornati ai piu' popolari siti web italiani.(torrent,streaming,download)<br>
                      Non dovrete preoccuparvi di cambi di dominio/censure DNS/ecc, il tool si auto-aggiorna e avrete sempre 
                      l'indirizzo web o IP del vostro sito preferito. Rapido e veloce.
                  <br><br><br>
				  <p>1.3 Changelog. Fix Auto Aggiornamento Lista e Tasto Manuale.</p>
                  <p>1.2 Changelog. Aggiuto tasto rapido WIN + Z</p>
                  <p>1.1 Changelog. Prima versione rilasciata</p>
                  
               </div>
            </div>
            
         </div>
      </section>
      <!-- End About Section -->
      
      <!-- Subscribe Section -->
      <section id="subscribe" data-direction="from-bottom">
         <div class="content">
            <h1>
               <span>non contiente virus / malware / pubblicita' di nessun tipo.</span>
            </h1>
            <!-- ./End Section Title -->
            <a href="#" class="close"></a>
            <div class="container">
               <div class="row text-center">
                  <div class="col-md-6 col-md-offset-3">
                     <!-- Subscribe form -->				
                     <div class="subscribe form-wrap">
                       
                           <a class="btn" href="http://www.mytrg.info/download.php" title="Download">Clicca qua per il Download di myTRG</a>
                         <br>
                           
                         <br><br>
                         
                              <p>Il tool e' anche portatile e aggiorna la lista dei bookmarks ad ogni avvio.</p>
                              <p>Non dovrete piu' preoccuparvi di cercare nuovi siti web, blocchi DNS e cambi di dominio del vostro sito preferito. </p>
                              <p>Aggiorneremo noi la lista con i nuovi indirizzi web o IP.</p>
                              
                              
                              
                        
                          
                          
                          
                          
                        
                        
                     </div>
                     <!-- End Subscribe form-->  	
                  
                  </div>
               </div>
            </div>
         </div>
      </section>
      <!-- End Subscribe Section -->
      
      <!-- Contact Section -->
      <section id="contact" data-direction="from-right">
         <div class="container">           
            <h1>
               <span>Contatti</span>
            </h1>
            <!-- ./End Section Title -->
            <a href="#" class="close"></a>
            <div class="row">
               <div class="col-md-8 col-md-offset-2">
                  <h4>Problemi? Scrivici.<br> Inoltre se hai siti web da segnalare validi scrivi pure!</h4>
            
                  <div class="clearfix"></div>
                  <div class="contactForm">
                  <!-- Start Contact Form -->                    	             
                       <iframe height="434" allowTransparency="true" frameborder="0" scrolling="no" style="width:100%;border:none"  src="https://mytrg.wufoo.com/embed/zley1kd15o83sd/"><a href="https://mytrg.wufoo.com/forms/zley1kd15o83sd/">Fill out my Wufoo form!</a></iframe><div id="wuf-adv" style="font-family:inherit;font-size: small;color:#a7a7a7;text-align:center;display:block;">Use <a href="http://www.wufoo.com/partners/">Wufoo integrations</a> and get your data to your favorite apps.</div>
         
                  <div class="successMsg"></div>
                  <!-- End Contact Form -->
                  </div>
               </div>
            </div>
         </div>
      </section>
      <!-- End Contact Section -->
      
      <!-- Loading... -->	     
      <div style="display: none;" id="preload">
         <div id="preload-content">
            <div class="preload-bounce">				           
               <span class="bounce1">
               </span>				           
               <span class="bounce2">
               </span>				           
               <span class="bounce3">
               </span>                   
               <span class="bounce4">
               </span>			         
            </div>
         </div>
      </div>
      <!-- ==============================================
         JS
         =============================================== -->         
      <script type="text/javascript" src="template/modernizr.js"></script>     
      <script type="text/javascript" src="template/jquery.js"></script>           
      <script type="text/javascript" src="template/bootstrap.js"></script>     
      <script type="text/javascript" src="template/plugins.js"></script>     
      <script type="text/javascript" src="template/init.js"></script><div style="left: 0px; top: 0px; overflow: hidden; margin: 0px; padding: 0px; height: 925px; width: 1920px; z-index: -9999; position: fixed;" class="backstretch"><img src="template/bg1.jpg" style="position: absolute; margin: 0px; padding: 0px; border: medium none; width: 1920px; height: 1080px; max-height: none; max-width: none; z-index: -999999; left: 0px; top: -77.5px;"></div>         
   
</body></html>