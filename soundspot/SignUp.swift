//
//  SignUp.swift
//  soundspot
//
//  Created by MO BALUSHI on 10/29/21.
//

import SwiftUI

struct SignUp: View {
    @State var mail = ""
    @State var Username = ""
    @State var pass = ""
    @State var rePass = ""
    @State var hide = true
    @State var hide2 = true
    
    var body: some View {
        VStack {
            VStack{
                HStack(spacing: 15){
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                        .frame(width: 25, height: 25)
                    TextField("Enter your mail", text: self.$mail)
                }.padding(.vertical, 20)
                    .padding(.top, 10)
                    .padding(.leading, 15)
                    .padding(.trailing, 10)
                
                Divider()
                
                HStack(spacing: 15){
                    Image(systemName: "person")
                        .foregroundColor(.black)
                        .frame(width: 25, height: 25)
                    TextField("Enter your Username", text: self.$Username)
                }.padding(.vertical, 20)
                    .padding(.top, 10)
                    .padding(.leading, 15)
                    .padding(.trailing, 10)
                
                Divider()
                HStack(spacing: 15){
                                   if !self.hide {
                                       Image(systemName: "lock")
                                           .resizable()
                                           .frame(width: 15, height: 18)
                                           .foregroundColor(.black)
                                       TextField("Enter your Password", text: self.$pass)
                                   }else {
                                       Image(systemName: "lock")
                                           .resizable()
                                           .frame(width: 15, height: 18)
                                           .foregroundColor(.black)
                                       SecureField("Enter your Password", text: self.$pass)
                                   }
                                   Button(action: {
                                       self.hide.toggle()
                                   }) {
                                       Image(systemName: "eye")
                                           .foregroundColor(self.hide ? .black : .green)
                                   }
                               }.padding(.vertical, 20)
                                   .padding(.bottom, 10)
                                   .padding(.leading, 20)
                                   .padding(.trailing, 10)
                
                Divider()
                
                HStack(spacing: 15){
                    if !self.hide2 {
                        Image(systemName: "lock")
                            .resizable()
                            .frame(width: 15, height: 18)
                            .foregroundColor(.black)
                        TextField("Enter your Password", text: self.$rePass)
                    }else {
                        Image(systemName: "lock")
                            .resizable()
                            .frame(width: 15, height: 18)
                            .foregroundColor(.black)
                        SecureField("Enter your Password", text: self.$rePass)
                    }
                    Button(action: {
                        self.hide2.toggle()
                    }) {
                        Image(systemName: "eye")
                            .foregroundColor(self.hide2 ? .black : .green)
                    }
                }.padding(.vertical, 20)
                    .padding(.bottom, 10)
                    .padding(.leading, 20)
                    .padding(.trailing, 10)
                
            }
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal, 20)
            
            NavigationLink(
                destination: NavBar().navigationBarBackButtonHidden(false).navigationBarHidden(false),
                label: {
                    Text("SignUp")
                        .font(.headline)
                        .frame(width: 200, height: 40, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)))
                        .cornerRadius(10)
                })
            Spacer()
//            Button(action: {
//
//            }) {
//                Text("Login")
//                    .padding(.vertical)
//                    .foregroundColor(Color.white)
//                    .frame(width: (UIScreen.main.bounds.width - 100))
//                    .font(Font.custom("", size: 24))
//
//            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(" "),Color(" "),Color(" ")]), startPoint: .leading, endPoint: .trailing)
            ).cornerRadius(10)
            .offset(y: -40)
                .shadow(radius: 20)
            
        }
        
    }
}

//struct SignUp_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUp().previewLayout(.sizeThatFits)
//    }
//}


