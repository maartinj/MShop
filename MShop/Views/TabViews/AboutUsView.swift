//
//  AboutUsView.swift
//  MShop
//
//  Created by Marcin Jędrzejak on 13/06/2022.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    
                    Text("About Us")
                        .font(.system(size: 28).bold())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    
                    VStack(spacing: 15) {
                        
                        Image("logo2")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .offset(y: -45)
                            .padding(.bottom, -40)
                        
                        Text("MSHOP")
                            .font(.custom(customFont, size: 25).bold())
                        
                        HStack(alignment: .top, spacing: 10) {
                            
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 90))
                            
                            Text("Address: Polna 8/34\n85-858\nBydgoszcz, Poland")
                                .font(.custom(customFont, size: 18))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.horizontal, .bottom])
                    .background(
                        
                        Color("Background")
                            .cornerRadius(10)
                    )
                    .padding()
                    .padding(.top, 40)
                    
                    VStack(spacing: 0) {
                        
                        HStack(alignment: .top, spacing: 10) {
                            
                            Image(systemName: "mail.fill")
                                .foregroundColor(.gray)
                            
                            Text(verbatim: "mail: info@mshop.pl")
                                .font(.custom(customFont, size: 18))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                        
                        HStack(alignment: .top, spacing: 10) {
                            
                            Image(systemName: "phone.fill")
                                .foregroundColor(.gray)
                            
                            Text(verbatim: "phone: +48 728 282 828")
                                .font(.custom(customFont, size: 18))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                        
                        HStack(alignment: .top, spacing: 10) {
                            
                            Image(systemName: "creditcard.fill")
                                .foregroundColor(.gray)
                            
                            Text(verbatim: "PKO BP S.A.\n11 1020 2641 0000 8913 1455 2130")
                                .font(.custom(customFont, size: 18))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                    }
                    .padding([.horizontal, .bottom])
                    .background(
                        
                        Color("Background")
                            .cornerRadius(10)
                    )
                    .padding()
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 20)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                
                Color.white
                    .ignoresSafeArea()
            )
        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
