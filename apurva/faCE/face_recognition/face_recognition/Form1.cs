using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Emgu.CV;
using Emgu.CV.Structure;
using Emgu.CV.CvEnum;
using System.IO;

namespace face_recognition
{
    public partial class Form1 : Form
    {
        Capture grabber;
        Image<Bgr, byte> CurrentFrame;
        Image<Gray, byte> gray,result,TrainedFace = null;
        HaarCascade face;
        List<Image<Gray, byte>> trainingImages = new List<Image<Gray, byte>>();
        List<string> labels = new List<string>();
        int NumLabels, ContTrain;
        int t = 0;

        public Form1()
        {
            face = new HaarCascade("haarcascade-frontalface-default.xml");
            InitializeComponent();
            try
            {
                string Labelsinfo = File.ReadAllText(Application.StartupPath + "/TrainedFaces/TrainedLabels.txt");
                string[] Labels = Labelsinfo.Split('%');
                NumLabels = Convert.ToInt16(Labels[0]);
                ContTrain = NumLabels;
                string Loadfaces;

                for( int tf=1;tf<NumLabels+1;tf++)
                {
                    Loadfaces = "face" + tf + ".bmp";
                    trainingImages.Add(new Image<Gray, byte>(Application.StartupPath + "/TrainedFaces" + Loadfaces));
                    labels.Add(Labels[tf]);
                }
            }
            catch(Exception e)
            {
                MessageBox.Show("train item if its first time");
            }
        }

        private void button1_Click(object sender, EventArgs e)    // when button1 clicked
        {
            grabber = new Capture();
            grabber.QueryFrame();
            Application.Idle += new EventHandler(FrameGrabber);
            button2.Visible = true;
        }

        
        void FrameGrabber(object sender, EventArgs e)          //enent of img box 1
        {
            CurrentFrame = grabber.QueryFrame().Resize(320, 240, Emgu.CV.CvEnum.INTER.CV_INTER_CUBIC);
            gray = CurrentFrame.Convert<Gray, byte>();
            MCvAvgComp[][] faceDetected = gray.DetectHaarCascade(
                face, 1.2, 10, Emgu.CV.CvEnum.HAAR_DETECTION_TYPE.DO_CANNY_PRUNING, new Size(20, 20));

            foreach (MCvAvgComp f in faceDetected[0]) // face detection
            {
                t = t + 1;
                result = CurrentFrame.Copy(f.rect).Convert<Gray, byte>().Resize(100, 100, Emgu.CV.CvEnum.INTER.CV_INTER_CUBIC);
                CurrentFrame.Draw(f.rect, new Bgr(Color.Red), 2);

            }

            imageBox1.Image = CurrentFrame;
            }
            private void button2_Click(object sender, EventArgs e) //when button 2 clicked
            {
            TrainedFace = result.Resize(100, 100, Emgu.CV.CvEnum.INTER.CV_INTER_CUBIC);
            imageBox2.Image = TrainedFace;
            label1.Visible = true;
            textBox1.Visible = true;
            button3.Visible = true;
            }

        private void button3_Click(object sender, EventArgs e) // when train face button clicked it will add
            {
            ContTrain = ContTrain + 1;
            trainingImages.Add(TrainedFace);
            labels.Add(textBox1.Text);
            File.WriteAllText(Application.StartupPath + "/TrainedFaces/TrainedLabels.txt", trainingImages.ToArray().Length.ToString() + "%");


            for (int i = 1; i<trainingImages.ToArray().Length+1; i++)

            {
                trainingImages.ToArray()[i - 1].Save(Application.StartupPath + "/TrainedFaces/face" + i + ".bmp");
                File.AppendAllText(Application.StartupPath + "/TrainedFaces/TrainedLabels.txt", labels.ToArray()[i - 1] + "%");
            }

            MessageBox.Show("image trained and save");
            }   


    }

}
