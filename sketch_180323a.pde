int difficulty=0; //difficulty 0 = easy 1 = normal 2 = hard
int[][] masu;    //bakudan
int[][] flag;    //bakudan_kazuu zumi ka?
int[][] choose;  // player no mark
int[][] bakudan_kazu;    //bakudan_kazuu()
int[][] aketatokoro;    //user ga hiraita tokoro
boolean game_start=false;    // game ha kaisi siteiruka?
int click_kaisu=-1;    //kurikku sita kaisu
long frames=0;
boolean bakudan_funda=false;
int baku_hiku_flag=0;
boolean isclear=false;

        //masu[x][y] masu[yoko][tate]

void setup(){
  size(700,780);
  frameRate(20);
  initialize();
  textSize(16);
}

void draw(){
  background(255);
  field_draw();
  if(game_start==true){
    if(bakudan_funda==false && isclear==false){frames++;}
    hyouji();
    clear_hantei();
  }
  
}

void clear_hantei(){
  if(difficulty==0){
    int flag=0;
    for(int i=0; i<9; i++){
      for(int j=0; j<9; j++){
        if(choose[i][j]==1){
          flag++;
        }
        if(choose[i][j]==1 && aketatokoro[i][j]==-1){
          choose[i][j]=0;
        }
      }
    }
    baku_hiku_flag=10-flag;
  }
  
  if(difficulty==1){
    int flag=0;
    for(int i=0; i<16; i++){
      for(int j=0; j<16; j++){
        if(choose[i][j]==1){
          flag++;
        }
      }
    }
    baku_hiku_flag=40-flag;
  }
  
  if(difficulty==2){
    int flag=0;
    for(int i=0; i<30; i++){
      for(int j=0; j<16; j++){
        if(choose[i][j]==1){
          flag++;
        }
      }
    }
    baku_hiku_flag=99-flag;
  }
}

void keyPressed(){
  if(key == '1' || key =='e' ){
    difficulty=0;
  }
  
  else if(key == '2' || key =='n' ){
    difficulty=1;
  }
  
  else if(key == '3' || key =='h' ){
    difficulty=2;
  }
  else if(key=='r'){
    // sai yomikomi
  }
  
  else if(key=='p'){
    String path  = System.getProperty("user.home") + "/Desktop/screenshot" + millis() + ".jpg";
    save(path);
  }
  if(key!='p'){
    initialize();
  }
      //iroiro na syoki ka syori wo suru
}

void mouseClicked(){
  if(mouseButton==LEFT && click_kaisu==-1 && game_start == false){
    if(difficulty==0 ){
      if(mouseX>35 && mouseX<665 && mouseY>120 && mouseY<750){
        game_start=true;  //game kaisi
        bakudan(mouseX,mouseY);
        open(mouseX,mouseY);
        click_kaisu++;
      }
    }
    
    else if(difficulty==1){
      if(mouseX>30 && mouseX<670 && mouseY>110 && mouseY<750){
        game_start=true;  //game kaisi
        bakudan(mouseX,mouseY);
        open(mouseX,mouseY);
        click_kaisu++;
      }
    }
    
    else if(difficulty==2){
      if(mouseX>35 && mouseX<665 && mouseY>220 && mouseY<556){
        game_start=true;  //game kaisi
        bakudan(mouseX,mouseY);
        open(mouseX,mouseY);
        click_kaisu++;
      }
    }
    
    
  }
  
  else if(mouseButton==LEFT && game_start == false){
  }
  
  if(mouseButton==RIGHT && click_kaisu == 0 && game_start == true){    //migi click no kyodou{
    r_cl(mouseX,mouseY);    // flag wo tateru
    
  }
  
  else if(mouseButton==LEFT && click_kaisu>=0 && game_start==true){
    open(mouseX,mouseY);
  }
}

void r_cl(int a,int b){    // migi click 1
  if(difficulty==0){
    if(a>=35 && 665>=a && b>=120 && b<=750){
      int yoko=(a-35)/70;
      int tate=(b-120)/70;
      if(aketatokoro[yoko][tate]==0){
        choose[yoko][tate]=(choose[yoko][tate]+1)%3;
      }
    }
  }
  
  else if(difficulty==1){
    if(a>=30 && 670>=a && b>=110 && b<=750){
      int yoko=(a-30)/40;
      int tate=(b-110)/40;
      if(aketatokoro[yoko][tate]==0){
        choose[yoko][tate]=(choose[yoko][tate]+1)%3;
      }
    }
  }
  
  else if(difficulty==2){
    if(a>=35 && 665>=a && b>=220 && b<=556){
      int yoko=(a-35)/21;
      int tate=(b-220)/21;
      if(aketatokoro[yoko][tate]==0){
        choose[yoko][tate]=(choose[yoko][tate]+1)%3;
      }
    }
  }
}

void bakudan(int a , int b){
  if(difficulty==0){
    if(a>=35 && 665>=a && b>=120 && b<=750){
      int yoko=(a-35)/70;
      int tate=(b-120)/70;
      for(int i=0; i<10;){    //bakudan
        int ran_x,ran_y;    //[ran_x ][ran_y]
        ran_x=(int)(Math.random()*9);
        ran_y=(int)(Math.random()*9);
          if(masu[ran_x][ran_y]==0 && ran_x!=yoko && ran_y!=tate){
            masu[ran_x][ran_y]=1;
            i++;
          }
      }
      
      for(int i=0; i<9; i++){
        for(int j=0; j<9; j++){
          if(masu[i][j]==0){
            if(i==0){    // hidarihasi
              if(j==0) bakudan_kazu[i][j]=masu[i+1][j]+masu[i+1][j+1]+masu[i][j+1];      //hidariue
              else if(j==8) bakudan_kazu[i][j]=masu[i+1][j]+masu[i+1][j-1]+masu[i][j-1];  //hidarisita
              else if(j>=1 && j<=7){
                bakudan_kazu[i][j]=masu[i+1][j]+masu[i+1][j-1]+masu[i+1][j+1]+masu[i][j+1]+masu[i][j-1];
              }
            }
            
            else if(i==8){    // migihasi
              if(j==0) bakudan_kazu[i][j]=masu[i-1][j]+masu[i-1][j+1]+masu[i][j+1];      //migiue
              else if(j==8) bakudan_kazu[i][j]=masu[i-1][j]+masu[i-1][j-1]+masu[i][j-1];  //migisita
              else if(j>=1 && j<=7){
                bakudan_kazu[i][j]=masu[i-1][j]+masu[i-1][j-1]+masu[i-1][j+1]+masu[i][j+1]+masu[i][j-1];
              }
            }
            
            else if(j==0 && i>0 && 8>i){
              bakudan_kazu[i][j]=masu[i-1][j]+masu[i+1][j]+masu[i][j+1]+masu[i-1][j+1]+masu[i+1][j+1];
            }
            
            else if(j==8 && i>0 && 8>i){
              bakudan_kazu[i][j]=masu[i-1][j]+masu[i+1][j]+masu[i][j-1]+masu[i-1][j-1]+masu[i+1][j-1];
            }
            
            else{
              bakudan_kazu[i][j]=masu[i-1][j]+masu[i+1][j]+masu[i-1][j+1]+masu[i+1][j+1]+masu[i-1][j-1]+masu[i+1][j-1]+masu[i][j+1]+masu[i][j-1];
            }
          }
          
          else if(masu[i][j]==1){
            bakudan_kazu[i][j]=10;
          }
        }
      }
    }
  }
  
  else if(difficulty==1){
    if(a>=30 && 670>=a && b>=110 && b<=750){
      int yoko=(a-30)/40;
      int tate=(b-110)/40;
      for(int i=0; i<40;){    //bakudan
        int ran_x,ran_y;    //[ran_x ][ran_y]
        ran_x=(int)(Math.random()*16);
        ran_y=(int)(Math.random()*16);
          if(masu[ran_x][ran_y]==0 && ran_x!=yoko && ran_y!=tate){
            masu[ran_x][ran_y]=1;
            i++;
          }
      }
      
      for(int i=0; i<16; i++){
        for(int j=0; j<16; j++){
          if(masu[i][j]==0){
            if(i==0){    // hidarihasi
              if(j==0) bakudan_kazu[i][j]=masu[i+1][j]+masu[i+1][j+1]+masu[i][j+1];      //hidariue
              else if(j==15) bakudan_kazu[i][j]=masu[i+1][j]+masu[i+1][j-1]+masu[i][j-1];  //hidarisita
              else if(j>=1 && j<=14){
                bakudan_kazu[i][j]=masu[i+1][j]+masu[i+1][j-1]+masu[i+1][j+1]+masu[i][j+1]+masu[i][j-1];
              }
            }
            
            else if(i==15){    // migihasi
              if(j==0) bakudan_kazu[i][j]=masu[i-1][j]+masu[i-1][j+1]+masu[i][j+1];      //migiue
              else if(j==15) bakudan_kazu[i][j]=masu[i-1][j]+masu[i-1][j-1]+masu[i][j-1];  //migisita
              else if(j>=1 && j<=14){
                bakudan_kazu[i][j]=masu[i-1][j]+masu[i-1][j-1]+masu[i-1][j+1]+masu[i][j+1]+masu[i][j-1];
              }
            }
            
            else if(j==0 && i>0 && 15>i){
              bakudan_kazu[i][j]=masu[i-1][j]+masu[i+1][j]+masu[i][j+1]+masu[i-1][j+1]+masu[i+1][j+1];
            }
            
            else if(j==15 && i>0 && 15>i){
              bakudan_kazu[i][j]=masu[i-1][j]+masu[i+1][j]+masu[i][j-1]+masu[i-1][j-1]+masu[i+1][j-1];
            }
            
            else{
              bakudan_kazu[i][j]=masu[i-1][j]+masu[i+1][j]+masu[i-1][j+1]+masu[i+1][j+1]+masu[i-1][j-1]+masu[i+1][j-1]+masu[i][j+1]+masu[i][j-1];
            }
          }
          
          else if(masu[i][j]==1){
            bakudan_kazu[i][j]=10;
          }
        }
      }
    }
  }
  
  else if(difficulty==2){
    if(a>=35 && 665>=a && b>=220 && b<=556){
      int yoko=(a-35)/21;
      int tate=(b-220)/21;
      for(int i=0; i<99;){    //bakudan
        int ran_x,ran_y;    //[ran_x ][ran_y]
        ran_x=(int)(Math.random()*30);
        ran_y=(int)(Math.random()*16);
          if(masu[ran_x][ran_y]==0 && ran_x!=yoko && ran_y!=tate){
            masu[ran_x][ran_y]=1;
            i++;
          }
      }
      
      for(int i=0; i<30; i++){
        for(int j=0; j<16; j++){
          if(masu[i][j]==0){
            if(i==0){    // hidarihasi
              if(j==0) bakudan_kazu[i][j]=masu[i+1][j]+masu[i+1][j+1]+masu[i][j+1];      //hidariue
              else if(j==15) bakudan_kazu[i][j]=masu[i+1][j]+masu[i+1][j-1]+masu[i][j-1];  //hidarisita
              else if(j>=1 && j<=15){
                bakudan_kazu[i][j]=masu[i+1][j]+masu[i+1][j-1]+masu[i+1][j+1]+masu[i][j+1]+masu[i][j-1];
              }
            }
            
            else if(i==29){    // migihasi
              if(j==0) bakudan_kazu[i][j]=masu[i-1][j]+masu[i-1][j+1]+masu[i][j+1];      //migiue
              else if(j==15) bakudan_kazu[i][j]=masu[i-1][j]+masu[i-1][j-1]+masu[i][j-1];  //migisita
              else if(j>=1 && j<=14){
                bakudan_kazu[i][j]=masu[i-1][j]+masu[i-1][j-1]+masu[i-1][j+1]+masu[i][j+1]+masu[i][j-1];
              }
            }
            
            else if(j==0 && i>0 && 29>i){
              bakudan_kazu[i][j]=masu[i-1][j]+masu[i+1][j]+masu[i][j+1]+masu[i-1][j+1]+masu[i+1][j+1];
            }
            
            else if(j==15 && i>0 && 29>i){
              bakudan_kazu[i][j]=masu[i-1][j]+masu[i+1][j]+masu[i][j-1]+masu[i-1][j-1]+masu[i+1][j-1];
            }
            
            else{
              bakudan_kazu[i][j]=masu[i-1][j]+masu[i+1][j]+masu[i-1][j+1]+masu[i+1][j+1]+masu[i-1][j-1]+masu[i+1][j-1]+masu[i][j+1]+masu[i][j-1];
            }
          }
          
          else if(masu[i][j]==1){
            bakudan_kazu[i][j]=10;
          }
        }
      }
    }
  }
}

    //masu[x][y]    yoko tate

void initialize(){    //syokikasyori
  if(difficulty==0){
    masu=new int[9][9];
    flag=new int[9][9];
    choose=new int[9][9];
    bakudan_kazu=new int[9][9];
    aketatokoro=new int[9][9];
    baku_hiku_flag=10;
  }
  
  else if(difficulty==1){
    masu=new int[16][16];
    flag=new int[16][16];
    choose=new int[16][16];
    bakudan_kazu=new int[16][16];
    aketatokoro=new int[16][16];
    baku_hiku_flag=40;
  }
  
  else if(difficulty==2){
    masu=new int[30][16];
    flag=new int[30][16];
    choose=new int[30][16];
    bakudan_kazu=new int[30][16];
    aketatokoro=new int[30][16];
    baku_hiku_flag=99;
  }
  click_kaisu=-1;
  game_start=false;
  bakudan_funda=false;
  isclear=false;
  frames=0;
}


void field_draw(){    //game ban wo byousya
  if(difficulty == 0){    //easy (35,120) ~ (665,750)
    for(int i=0; i<10; i++){
      for(int j=0; j<10; j++){
        line(35+j*70,120,35+j*70,750);    // tate LINE
        line(35,120+i*70,665,120+i*70);  //yoko LINE
      }
    }
  }
  
  else if(difficulty == 1){    //normal (30,110) ~ (670,750)
    for(int i=0; i<17; i++){
      for(int j=0; j<17; j++){
        line(30+j*40,110,30+j*40,750);    // tate LINE
        line(30,110+i*40,670,110+i*40);  //yoko LINE
      }
    }
  }
  
  else if(difficulty == 2){    //hard (35,220) ~ (665,556)  30x16
    for(int i=0; i<17; i++){
      for(int j=0; j<31; j++){
        line(35+j*21,220,35+j*21,556);    // tate LINE
        line(35,220+i*21,665,220+i*21);  //yoko LINE
      }
    }
  }
}

void hyouji(){  //iroiro hyouji
  fill(0);
  
  text("TIME:"+(int)(frames/20)+"."+((int)frames%20)/2+"s",20,20);
  text("BOMB:"+baku_hiku_flag,500,80);
  
  if(isclear==true){
    text("CLEAR SCORE:"+(int)(10000000/frames),350,60);
}
  
  if(difficulty==0){
    for(int i=0; i<9; i++){
      for(int j=0; j<9; j++){
                
        if(choose[i][j]==0){
          text("",70+i*70,170+j*70);
        }
        
        else if(choose[i][j]==1){
          text("X",70+i*70,170+j*70);
        }
        
        else if(choose[i][j]==2){
          text("?",70+i*70,170+j*70);
        }
        
        if(masu[i][j]!=0 && bakudan_funda==true){
          text("B",70+i*70,155+j*70);    //bakudan
        }
        
        if(aketatokoro[i][j]!=0 && bakudan_kazu[i][j]!=0 && bakudan_kazu[i][j]!=10){
          text(bakudan_kazu[i][j],70+i*70,140+j*70);
        }
        
        else if(aketatokoro[i][j]==0){
          fill(80,80,80,50);
          rect(35+i*70,120+j*70,70,70);
          fill(0);
        }

      }
    }
  }
  
  if(difficulty==1){
    for(int i=0; i<16; i++){
      for(int j=0; j<16; j++){
                
        if(choose[i][j]==0){
          text("",40+i*40,140+j*40);
        }
        
        else if(choose[i][j]==1){
          text("X",40+i*40,140+j*40);
        }
        
        else if(choose[i][j]==2){
          text("?",40+i*40,140+j*40);
        }
        
        if(masu[i][j]!=0 && bakudan_funda==true){
          text("B",40+i*40,140+j*40);    //bakudan
        }
        
        if(aketatokoro[i][j]!=0 && bakudan_kazu[i][j]!=0 && bakudan_kazu[i][j]!=10){
          text(bakudan_kazu[i][j],40+i*40,140+j*40);
        }
        
        else if(aketatokoro[i][j]==0){
          fill(80,80,80,50);
          rect(30+i*40,110+j*40,40,40);
          fill(0);
        }

      }
    }
  }
  
  if(difficulty==2){
    for(int i=0; i<30; i++){
      for(int j=0; j<16; j++){
                
        if(choose[i][j]==0){
          text("",40+i*21,235+j*21);
        }
        
        else if(choose[i][j]==1){
          text("X",40+i*21,235+j*21);
        }
        
        else if(choose[i][j]==2){
          text("?",40+i*21,235+j*21);
        }
        
        if(masu[i][j]!=0 && bakudan_funda==true){
          text("B",40+i*21,235+j*21);    //bakudan
        }
        
        if(aketatokoro[i][j]!=0 && bakudan_kazu[i][j]!=0 && bakudan_kazu[i][j]!=10){
          text(bakudan_kazu[i][j],40+i*21,235+j*21);
        }
        
        else if(aketatokoro[i][j]==0){
          fill(80,80,80,50);
          rect(35+i*21,220+j*21,21,21);
          fill(0);
        }

      }
    }
  }
}

void open(int a,int b){
  if(bakudan_funda==false){
    if(difficulty==0){
      if(a>=35 && 665>=a && b>=120 && b<=750){
        int yoko=(a-35)/70;
        int tate=(b-120)/70;
  
        int bk_kz=0; //bakudan no kazu
        
          if(yoko==0){    // hidarihasi
            if(tate==0) bk_kz=masu[yoko+1][tate]+masu[yoko+1][tate+1]+masu[yoko][tate+1];      //hidariue
            else if(tate==8) bk_kz=masu[yoko+1][tate]+masu[yoko+1][tate-1]+masu[yoko][tate-1];  //hidarisita
            else if(tate>=1 && tate<=7){
              bk_kz=masu[yoko+1][tate]+masu[yoko+1][tate-1]+masu[yoko+1][tate+1]+masu[yoko][tate+1]+masu[yoko][tate-1];
            }
          }
          
          else if(yoko==8){    // migihasi
            if(tate==0) bk_kz=masu[yoko-1][tate]+masu[yoko-1][tate+1]+masu[yoko][tate+1];      //migiue
            else if(tate==8) bk_kz=masu[yoko-1][tate]+masu[yoko-1][tate-1]+masu[yoko][tate-1];  //migisita
            else if(tate>=1 && tate<=7){
              bk_kz=masu[yoko-1][tate]+masu[yoko-1][tate-1]+masu[yoko-1][tate+1]+masu[yoko][tate+1]+masu[yoko][tate-1];
            }
          }
          
          else if(tate==0 && yoko>0 && 8>yoko){
            bk_kz=masu[yoko-1][tate]+masu[yoko+1][tate]+masu[yoko][tate+1]+masu[yoko-1][tate+1]+masu[yoko+1][tate+1];
          }
          
          else if(tate==8 && yoko>0 && 8>yoko){
            bk_kz=masu[yoko-1][tate]+masu[yoko+1][tate]+masu[yoko][tate-1]+masu[yoko-1][tate-1]+masu[yoko+1][tate-1];
          }
          
          else{
            bk_kz=masu[yoko-1][tate]+masu[yoko+1][tate]+masu[yoko-1][tate+1]+masu[yoko+1][tate+1]+masu[yoko-1][tate-1]+masu[yoko+1][tate-1]+masu[yoko][tate+1]+masu[yoko][tate-1];
          }
  
        if(masu[yoko][tate] ==0 && bk_kz==0 && aketatokoro[yoko][tate]==0){
          aketatokoro[yoko][tate]=-1;
          
          open(Math.max(a-70,36),b);
          open(Math.min(a+70,664),b);
          open(a,Math.max(b-70,121));
          open(a,Math.min(b+70,749));
  
        }
        
        else if(masu[yoko][tate]==0){
          aketatokoro[yoko][tate]=-1;
        }
        
        else if(masu[yoko][tate]!=0){
          aketatokoro[yoko][tate]=-1;
          bakudan_funda=true;
        }
      }
      //clear hantei
      int clear_flag=0;
      for(int i=0; i<9; i++){
        for(int j=0; j<9; j++){
          if(masu[i][j]==1 && choose[i][j]==1){
            clear_flag++;
          }
        }
      }
      if(clear_flag==10 && baku_hiku_flag==0){
        isclear=true;
      }
    }
    
    if(difficulty==1){
      if(a>=30 && 670>=a && b>=110 && b<=750){
        int yoko=(a-30)/40;
        int tate=(b-110)/40;
  
        int bk_kz=0; //bakudan no kazu
        
          if(yoko==0){    // hidarihasi
            if(tate==0) bk_kz=masu[yoko+1][tate]+masu[yoko+1][tate+1]+masu[yoko][tate+1];      //hidariue
            else if(tate==15) bk_kz=masu[yoko+1][tate]+masu[yoko+1][tate-1]+masu[yoko][tate-1];  //hidarisita
            else if(tate>=1 && tate<=14){
              bk_kz=masu[yoko+1][tate]+masu[yoko+1][tate-1]+masu[yoko+1][tate+1]+masu[yoko][tate+1]+masu[yoko][tate-1];
            }
          }
          
          else if(yoko==15){    // migihasi
            if(tate==0) bk_kz=masu[yoko-1][tate]+masu[yoko-1][tate+1]+masu[yoko][tate+1];      //migiue
            else if(tate==15) bk_kz=masu[yoko-1][tate]+masu[yoko-1][tate-1]+masu[yoko][tate-1];  //migisita
            else if(tate>=1 && tate<=14){
              bk_kz=masu[yoko-1][tate]+masu[yoko-1][tate-1]+masu[yoko-1][tate+1]+masu[yoko][tate+1]+masu[yoko][tate-1];
            }
          }
          
          else if(tate==0 && yoko>0 && 15>yoko){
            bk_kz=masu[yoko-1][tate]+masu[yoko+1][tate]+masu[yoko][tate+1]+masu[yoko-1][tate+1]+masu[yoko+1][tate+1];
          }
          
          else if(tate==15 && yoko>0 && 15>yoko){
            bk_kz=masu[yoko-1][tate]+masu[yoko+1][tate]+masu[yoko][tate-1]+masu[yoko-1][tate-1]+masu[yoko+1][tate-1];
          }
          
          else{
            bk_kz=masu[yoko-1][tate]+masu[yoko+1][tate]+masu[yoko-1][tate+1]+masu[yoko+1][tate+1]+masu[yoko-1][tate-1]+masu[yoko+1][tate-1]+masu[yoko][tate+1]+masu[yoko][tate-1];
          }
  
        if(masu[yoko][tate] ==0 && bk_kz==0 && aketatokoro[yoko][tate]==0){
          aketatokoro[yoko][tate]=-1;
          
          open(Math.max(a-40,31),b);
          open(Math.min(a+40,669),b);
          open(a,Math.max(b-40,111));
          open(a,Math.min(b+40,749));
  
        }
        
        else if(masu[yoko][tate]==0){
          aketatokoro[yoko][tate]=-1;
        }
        
        else if(masu[yoko][tate]!=0){
          aketatokoro[yoko][tate]=-1;
          bakudan_funda=true;
        }
      }
      //clear hantei
      int clear_flag=0;
      for(int i=0; i<16; i++){
        for(int j=0; j<16; j++){
          if(masu[i][j]==1 && choose[i][j]==1){
            clear_flag++;
          }
        }
      }
      if(clear_flag==40 && baku_hiku_flag==0){
        isclear=true;
      }
    }
    
    if(difficulty==2){
      if(a>=35 && 665>=a && b>=220 && b<=556){
        int yoko=(a-35)/21;
        int tate=(b-220)/21;
  
        int bk_kz=0; //bakudan no kazu
        
          if(yoko==0){    // hidarihasi
            if(tate==0) bk_kz=masu[yoko+1][tate]+masu[yoko+1][tate+1]+masu[yoko][tate+1];      //hidariue
            else if(tate==15) bk_kz=masu[yoko+1][tate]+masu[yoko+1][tate-1]+masu[yoko][tate-1];  //hidarisita
            else if(tate>=1 && tate<=14){
              bk_kz=masu[yoko+1][tate]+masu[yoko+1][tate-1]+masu[yoko+1][tate+1]+masu[yoko][tate+1]+masu[yoko][tate-1];
            }
          }
          
          else if(yoko==29){    // migihasi
            if(tate==0) bk_kz=masu[yoko-1][tate]+masu[yoko-1][tate+1]+masu[yoko][tate+1];      //migiue
            else if(tate==15) bk_kz=masu[yoko-1][tate]+masu[yoko-1][tate-1]+masu[yoko][tate-1];  //migisita
            else if(tate>=1 && tate<=14){
              bk_kz=masu[yoko-1][tate]+masu[yoko-1][tate-1]+masu[yoko-1][tate+1]+masu[yoko][tate+1]+masu[yoko][tate-1];
            }
          }
          
          else if(tate==0 && yoko>0 && 29>yoko){
            bk_kz=masu[yoko-1][tate]+masu[yoko+1][tate]+masu[yoko][tate+1]+masu[yoko-1][tate+1]+masu[yoko+1][tate+1];
          }
          
          else if(tate==15 && yoko>0 && 29>yoko){
            bk_kz=masu[yoko-1][tate]+masu[yoko+1][tate]+masu[yoko][tate-1]+masu[yoko-1][tate-1]+masu[yoko+1][tate-1];
          }
          
          else{
            bk_kz=masu[yoko-1][tate]+masu[yoko+1][tate]+masu[yoko-1][tate+1]+masu[yoko+1][tate+1]+masu[yoko-1][tate-1]+masu[yoko+1][tate-1]+masu[yoko][tate+1]+masu[yoko][tate-1];
          }
  
        if(masu[yoko][tate] ==0 && bk_kz==0 && aketatokoro[yoko][tate]==0){
          aketatokoro[yoko][tate]=-1;
          
          open(Math.max(a-21,36),b);
          open(Math.min(a+21,664),b);
          open(a,Math.max(b-21,221));
          open(a,Math.min(b+21,555));
  
        }
        
        else if(masu[yoko][tate]==0){
          aketatokoro[yoko][tate]=-1;
        }
        
        else if(masu[yoko][tate]!=0){
          aketatokoro[yoko][tate]=-1;
          bakudan_funda=true;
        }
      }
      //clear hantei
      int clear_flag=0;
      for(int i=0; i<30; i++){
        for(int j=0; j<16; j++){
          if(masu[i][j]==1 && choose[i][j]==1){
            clear_flag++;
          }
        }
      }
      if(clear_flag==99 && baku_hiku_flag==0){
        isclear=true;
      }
    }
  }
}


//  aaaaaaaaaaaaaaaaaaaaaa
//   umaku ikanai   20180408
/*








if(bakudan_kazu[Math.min(0,a-1)][b]==0){
        }




*/
