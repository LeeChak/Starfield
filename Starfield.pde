Particle[] stars;
void setup()
{
	size(600,600);
	frameRate(60);
	stars = new Particle[500];
	for(int i=0; i<stars.length; i++){
		if(i%60==0)
			stars[i] = new OddballParticle();
		else if(i%200==1)
			stars[i] = new JumboParticle();
		else
			stars[i] = new NormalParticle();
	}
}

void draw()
{
	background(0);
	for(int i=0; i<stars.length; i++){
		stars[i].move();
		stars[i].stayIn();
		stars[i].show();
	}
	fill(0);
	ellipse(300,300,100,100);
	for(int i=0; i<stars.length; i++){
		if(stars[i] instanceof OddballParticle)
			stars[i].show();
	}
}



void mousePressed(){
	for(int i=0; i<stars.length; i++){
		stars[i].restart();
	}
}

interface Particle
{
	public void stayIn();
	public void move();
	public void show();
	public void restart();
}

class NormalParticle implements Particle
{
	double x, y;
	public int col;
	double angle, speedO, speedN, distance;
	float sizeO, sizeN;
	NormalParticle(){
		x=Math.random()*700-50;
		y=Math.random()*700-50;
		distance = dist((float)x,(float)y,300.0,300.0);
		if(y>300){
			if(x>300)
				angle = Math.acos((x-300)/distance);
			else
				angle = Math.acos((x-300)/distance);
		}
		else{
			if(x>300)
				angle = -(Math.acos((x-300)/distance));
			else
				angle = -(Math.acos((x-300)/distance));
		}
		col = 255;
		speedO = Math.random()*5+4;
		speedN = speedO;
		sizeO = (float)(Math.random()*2+0.5);
		sizeN = sizeO;
	}
	public void move(){
		x-=Math.cos(angle)*speedN;
		y-=Math.sin(angle)*speedN;
	}
	public void show(){
		fill(col);
		sizeN = sizeO + (float)(Math.abs(300-x)/50) + (float)(Math.abs(300-y)/50);
		speedN = speedO -((float)(Math.abs(300-x)/200) + (float)(Math.abs(300-y)/200));
		ellipse((float)x, (float)y, sizeN,sizeN);
	}
	public void restart(){
		while((x>0 && x<600) || (y>0 && y<600)){
			y= Math.random()*1000-200;
			x= Math.random()*1000-200;
		}
		if(x<0 || x>600){
			y= Math.random()*1000-200;
		}
		if(y<0 || y>600){
			x= Math.random()*1000-200;
		}
		distance = dist((float)x,(float)y,300.0,300.0);
		if(y>300){
			if(x>300)
				angle = Math.acos((x-300)/distance);
			else
				angle = Math.acos((x-300)/distance);
		}
		else{
			if(x>300)
				angle = -(Math.acos((x-300)/distance));
			else
				angle = -(Math.acos((x-300)/distance));
		}
		speedO = Math.random()*5+4;
		speedN = speedO;
		sizeN = sizeO;
	}
	public void stayIn(){
		if(dist((float)x,(float)y,300.0,300.0)<50 || x>700 || x<-100 || y>700 || y<-100)
			restart();
	}
	double highRandom(){
		double a = 0;
		while(a<600 && a>-600){
			a= Math.random()*1400-700;
		}
		return a;
	}
}

class OddballParticle implements Particle
{
	double x, y;
	public int col;
	OddballParticle(){
		x=300;
		y=300;
		col = color((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256));
	}
	public void move(){
		x= x+ (Math.random()*16)-8;
		y= y+ (Math.random()*16)-8;
	}
	public void show(){
		col = color((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256));
		fill(col);
		ellipse((float)x, (float)y, (float)(Math.random()*12)+3,(float)(Math.random()*12)+3);
	}
	public void restart(){
		x= 300;
		y= 300;
	}
	public void stayIn(){
		if(x<-50 || x>650 || y<-50 || y>650)
			restart();
	}
}
class JumboParticle extends NormalParticle
{
	JumboParticle(){
		sizeO = (float)(Math.random()*10+30);
		speedO = Math.random()*3+2;
		col = color((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256));
	}
	public void restart(){
		x=highRandom();
		y=highRandom();
		distance = dist((float)x,(float)y,300.0,300.0);
		if(y>300){
			if(x>300)
				angle = Math.acos((x-300)/distance);
			else
				angle = Math.acos((x-300)/distance);
		}
		else{
			if(x>300)
				angle = -(Math.acos((x-300)/distance));
			else
				angle = -(Math.acos((x-300)/distance));
		}
		speedO = Math.random()*5+4;
		speedN = speedO;
		sizeN = sizeO;
		col = color((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256));
	}
}

