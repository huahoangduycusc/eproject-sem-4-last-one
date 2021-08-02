package entities;

import entities.Accounts;
import entities.Artists;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2021-08-02T12:01:06")
@StaticMetamodel(ArtistFollow.class)
public class ArtistFollow_ { 

    public static volatile SingularAttribute<ArtistFollow, Integer> followID;
    public static volatile SingularAttribute<ArtistFollow, Accounts> accountID;
    public static volatile SingularAttribute<ArtistFollow, Artists> artistID;

}