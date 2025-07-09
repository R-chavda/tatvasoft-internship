using Mission.Entities.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;


namespace Mission.Entities
{
    public class MissionDbContext : DbContext
    {
        public MissionDbContext(DbContextOptions<MissionDbContext> options)
            : base(options)
        {
        }

        public DbSet<User> Users { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>().HasData(new User()
            {
                Id = 1,
                FirstName = "Admin",
                LastName = "tatvasoft",
                EmailAddress = "admin@tatvasoft.com",
                Password = "admin",
                PhoneNumber = "01234567890",
                UserType = "admin",
            });

            base.OnModelCreating(modelBuilder);
        }
    }

}
