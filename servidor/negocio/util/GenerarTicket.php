<?php
    require_once 'fpdf.php';
    //$ImagePath = dirname(__FILE__)."\logo.jpg";
    //$pdf->Cell(10,10, $pdf->Image($ImagePath, $pdf->GetX(), $pdf->GetY(),30));
    class GenerarTicket extends FPDF {
        public function crearPDF($data){
            
            try {
                
                $jump = 8;
                //
                $pdf = new FPDF($orientation='P',$unit='mm', array(80,350)); 
                $pdf->AddPage(); 
                $pdf->Image(dirname(__FILE__)."\logo.jpg", 30, $pdf->GetY(),20);
                $pdf->Ln(25); //SALTO
                $pdf->SetFont('Arial','B',14);                
                $pdf->Cell(0,$jump,utf8_decode("PERUANDINO CAFÉ"),0,0,'C');
                $pdf->Ln(); //SALTO
                $pdf->SetFont('Arial','B',10); 
                $pdf->Cell(0,$jump,"RUC 20487859487",0,0,'C');
                $pdf->Ln();
                
                $pdf->SetFont('Arial','',10); 
                $pdf->Cell(0,$jump,"PRINCIPAL",0,0,'C');
                $pdf->Ln(); //SALTO
                $pdf->MultiCell(0,4,utf8_decode("AV. MARISCAL CASTILLA NRO. 1425 SEC. PUEBLO LIBRE - CAJAMARCA JAEN JAEN"),0,'C');
                $pdf->Ln(); //SALTO
                $pdf->Cell(0,4,"CEL: 939 418 140",0,0,'C');
                $pdf->Ln(); //SALTO
                $pdf->Cell(0,4,"Telf: 076 301840",0,0,'C');
                $pdf->Ln(); //SALTO
                $pdf->Cell(0,4,"Correo: cafeperuandino@gmail.com",0,0,'C');
                $pdf->Ln(10); //SALTO
                $pdf->Cell(0,4,utf8_decode($data["tipo"]),0,0,'C');
                $pdf->Ln(); //SALTO
                $pdf->Cell(0,$jump,$data["comprobante"],0,0,'C');
                $pdf->Ln(); //SALTO
                // DATA CLIENTE //
                $this->TablaDataCliente($pdf,$data["cliente"]);
                // DATA PRODUCTOS //                
                $this->TablaDataProducto($pdf,$data["toma_pedido"]);
                
                // DATA IMPORTE
                $this->TablaImporte($pdf,$data["toma_pedido"]);
                $pdf->Ln(5); //SALTO
                $this->TablaDataPie($pdf);

                $pdf->MultiCell(0,5,utf8_decode("Autorizado mediante resolución Resolución Nro. 0340050005929/SUNAT Representación impresa de la ". $data["tipo"]),0,'C');
                $pdf->Ln();
                $pdf->Cell(0,5,utf8_decode("MUCHAS GRACIAS POR SU COMPRA"),0,0,"C");

                $pdf->Ln(); //SALTO
                $pdf->Cell(0,$jump,"QR",0,0,'C');
                $pdf->Ln(); //SALTO


                
                $pdf->Output("../pdf/newpdf.pdf","F");
            } catch (\Throwable $th) {
                var_dump($th);
                exit();
            }
            

        }

        public function TablaDataCliente($pdf,$cols){
            foreach($cols as $col){                
                $pdf->setX(5);
                $pdf->SetFont('Arial','B',8); 
                $pdf->Cell(25,6,utf8_decode($col["descripcion"]));
                $pdf->setX(30);
                $pdf->SetFont('Arial','',8);
                $pdf->MultiCell(45,6,utf8_decode($col["texto"]));  
            }
            $pdf->Cell(0,5,"............................................................................................",0,0,'C');
            $pdf->Ln();
        }

        public function TablaDataProducto($pdf,$cols){
            $x = 5;
            $widths = [28,10,16,16];
            $headers = ["DESCRIPCIÓN","CANT","PRECIO","TOTAL"];

            $pdf->SetFont('Arial','B',8);
            $pdf->setX($x); 
            foreach( $widths as $key=>$width ) {
                $pdf->Cell($width,6,utf8_decode($headers[$key]),0,0, $key > 0 && "R");
                $x += $width;
                $pdf->setX($x);
            }
            $x = 5;
            $pdf->Ln();


            $pdf->SetFont('Arial','',8);
            $products = json_decode($cols,true);

            
            foreach( $products as $product ){
                $pdf->setX($x);
                $nb = 0;
                $nb = max($nb,$this->NbLines($pdf,$widths[0],$product["producto"]));
                $h = 5 * $nb;
                foreach ($widths as $key=>$width) {
                    $x1 = $pdf->GetX();
                    $x2 = $pdf->GetY();
                    switch ($key) {
                        case 0:
                            $pdf->MultiCell($width,5,$product["producto"],0);
                            $x = $x1 + $width;
                            $pdf->SetXY($x,$x2);
                            break;
                        case 1:
                            $pdf->MultiCell($width,5,$product["cantidad"],0,"R");
                            $x = $x1 + $width;
                            $pdf->SetXY($x,$x2);
                            break;
                        case 2:
                            $pdf->MultiCell($width,5,$product["precio"],0,"R");
                            $x = $x1 + $width;
                            $pdf->SetXY($x,$x2);
                            break;
                        case 3:
                            $pdf->MultiCell($width,5,$product["importe"],0,"R");
                            $x = $x1 + $width;
                            $pdf->SetXY($x,$x2);
                            break;
                    }
                }
                $pdf->Ln($h);
                $x = 5;
            }        
            $pdf->Cell(0,0,"............................................................................................",0,0,'C');            
            $pdf->Ln(2);
        }

        public function NbLines($pdf,$w,$txt){
            //Calcula el número de líneas que tomará una MultiCell de ancho w
            $cw=&$pdf->CurrentFont['cw'];            
            if($w==0)
                $w=$pdf->w-$pdf->rMargin-$pdf->x;
                
            $wmax=($w-2*$pdf->cMargin)*1000/$pdf->FontSize;
            
            $s=str_replace("\r",'',$txt);
            
            $nb=strlen($s);
            if($nb>0 and $s[$nb-1]=="\n")
                $nb--;
            $sep=-1;
            $i=0;
            $j=0;
            $l=0;
            $nl=1;
            while($i<$nb)
            {
                $c=$s[$i];
                if($c=="\n")
                {
                    $i++;
                    $sep=-1;
                    $j=$i;
                    $l=0;
                    $nl++;
                    continue;
                }
                if($c==' ')
                    $sep=$i;
                $l+=$cw[$c];
                if($l>$wmax)
                {
                    if($sep==-1)
                    {
                        if($i==$j)
                            $i++;
                    }
                    else
                        $i=$sep+1;
                    $sep=-1;
                    $j=$i;
                    $l=0;
                    $nl++;
                }
                else
                    $i++;
            }
            return $nl;
        }

        public function TablaImporte($pdf,$cols){
            $total = 0;
            $products = json_decode($cols,true);
            foreach ($products as $product) {
                $total += intval($product["importe"]);                
            }

            $cols = [
                [
                    "descripcion"=>"EXONERADO",
                    "texto"=>number_format($total, 2)
                ],
                [
                    "descripcion"=>"I.G.V. 18%",
                    "texto"=>"0.00"
                ],
                [
                    "descripcion"=>"TOTAL",
                    "texto"=>number_format($total, 2)
                ]
            ];

            foreach ($cols as $col) {
                $pdf->setX(5);
                $pdf->SetFont('Arial','B',8); 
                $pdf->Cell(25,6,utf8_decode($col["descripcion"]));
                $pdf->setX(30);
                $pdf->SetFont('Arial','',8);
                $pdf->Cell(45,6,utf8_decode($col["texto"]),0,0,"R");  
                $pdf->Ln();               
            }
            $pdf->setX(5);
            $pdf->SetFont('Arial','',6); 
            $pdf->Cell(0,6,utf8_decode("SON: CIENTO CINCUENTA Y DOS Y 10/100 SOLES"));
            $pdf->Ln();
            $pdf->SetFont('Arial','',8);
            $pdf->Cell(0,0,"............................................................................................",0,0,'C');            
        }

        public function TablaDataPie($pdf){
            $cols = [
                [
                    "descripcion"=>"VENDEDOR",
                    "texto" => "Cesar"
                ],
                [
                    "descripcion"=>"OBSERVACIÓN",
                    "texto" => ""
                ]
            ];

            foreach($cols as $col){                
                $pdf->setX(5);
                $pdf->SetFont('Arial','B',8); 
                $pdf->Cell(25,6,utf8_decode($col["descripcion"]));
                $pdf->setX(30);
                $pdf->SetFont('Arial','',8);
                $pdf->MultiCell(45,6,utf8_decode($col["texto"]));  
            }
            $pdf->Ln();
        }
    }
?>