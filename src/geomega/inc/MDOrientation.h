/*
 * MDOrientation.h
 *
 * Copyright (C) by Andreas Zoglauer.
 * All rights reserved.
 *
 * Please see the source-file for the copyright-notice.
 *
 */


#ifndef __MDOrientation__
#define __MDOrientation__


////////////////////////////////////////////////////////////////////////////////


// Standard libs:
#include <vector>
using namespace std; 

// ROOT libs:
#include "TRotMatrix.h"
#include "TMatrixD.h"
#include "TGeoMatrix.h"

// MEGAlib libs:
#include "MGlobal.h"
#include "MTokenizer.h"
#include "MDDebugInfo.h"

// Forward declarations:


////////////////////////////////////////////////////////////////////////////////


class MDOrientation
{
  // This is a named orientation consiting of a vector and a rotation matrix

  // public interface:
 public:
  //! Standard constructor with the name of the vector
  MDOrientation(const MString Name);
  //! Standard copy constructor
  MDOrientation(const MDOrientation& V);
  //! Default destructor
  virtual ~MDOrientation();

  //! Return the name of the vector
  MString GetName() const { return m_Name; }
  //! Set the name of the vector
  void SetName(const MString& Name) { m_Name = Name; }

  //! Validate the data and create the shape 
  bool Validate();  
  
  //! Parse some tokenized text
  bool Parse(const MTokenizer& Tokenizer, const MDDebugInfo& Info);

  //! Return the ROOT matrix
  TGeoMatrix* GetRootMatrix() { return m_RootMatrix; }
  
  //! Set the translation
  void SetPosition(MVector Position);
  //! Set the translation
  MVector GetPosition() const { return m_Position; }


  //! Set the rotation
  void SetRotation(double x, double y, double z);
  //! Set the rotation 
  void SetRotation(TMatrixD Rotation);
  //! Set the rotation
  void SetRotation(TMatrixD RotationMatrix, int RotID);
  //! Set the rotation in Euler notarion   
  void SetRotation(double theta1, double phi1, 
                   double theta2, double phi2, 
                   double theta3, double phi3);
  //! Return as a rotation matrix
  TMatrixD GetRotationMatrix() const { return m_RotMatrix; }
  //! Return the inverted rotation matrix
  TMatrixD GetInvRotationMatrix() const { return m_InvertedRotMatrix; }
  //! The if we have a rotation
  bool IsRotated() const;

  // protected methods:
 protected:

   
  // private methods:
 private:


  // protected members:
 protected:


  // private members:
 private:
  //! Name of the vector
  MString m_Name;
  
  //! The translation of the volume 
  MVector m_Position;

  //! True is this volume is rotated
  bool m_IsRotated;
  //! The rotation matrix
  TMatrixD m_RotMatrix;
  //! The inverted rotation matrix
  TMatrixD m_InvertedRotMatrix;
  //! Rotation of the new x-Axis in MCS (Mother Coordinate System)
  double m_Theta1, m_Phi1;   
  //! Rotation of the new y-Axis in MCS
  double m_Theta2, m_Phi2;
  //! Rotation of the new z-Axis in MCS
  double m_Theta3, m_Phi3;

  //! The whole thing as ROOT matrix
  TGeoMatrix* m_RootMatrix;

#ifdef ___CINT___
 public:
  ClassDef(MDOrientation, 0) // no description
#endif

};

#endif


////////////////////////////////////////////////////////////////////////////////
